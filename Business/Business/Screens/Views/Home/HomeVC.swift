//
//  HomeVC.swift
//  Business
//
//  Created by Tulakshana Weerasooriya on 2022-02-01.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            // Placeholder
            let attribString = NSMutableAttributedString.init(string: NSLocalizedString("placeholder_search", comment: "Type in what you are looking for"))
            attribString.addAttributes([NSAttributedString.Key.font: Style.Font.paragraph.value()], range: NSMakeRange(0, attribString.length))
            attribString.addAttributes([NSAttributedString.Key.foregroundColor: Style.Color.placeholder.value()], range: NSMakeRange(0, attribString.length))
            searchTextField.attributedPlaceholder = attribString
            
            // Search term
            searchTextField.font = Style.Font.paragraph.value()
            searchTextField.textColor = Style.Color.text.value()
            
            searchTextField.delegate = self
            searchTextField.returnKeyType = .search
        }
    }
    
    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.font = Style.Font.paragraph.value()
            errorLabel.textColor = Style.Color.error.value()
        }
    }
    
    @IBOutlet weak var searchResultsTable: UITableView! {
        didSet {
            searchResultsTable.register(UINib.init(nibName: SearchCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: SearchCell.reuseIdentifier)
            searchResultsTable.dataSource = self
        }
    }
    
    // MARK: -
    
    private let viewModel = HomeViewModel()
    
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        viewModel.startLocationService()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveDidBecomeActiveNotification(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchTextField.becomeFirstResponder()
    }

    // MARK: -
    
    @objc private func didReceiveDidBecomeActiveNotification(notification: Notification) {
        errorLabel.text = ""
        viewModel.startLocationService()
    }

}

extension HomeVC: HomeDelegate {
    func homeDidReceiveNewSearchResults(model: HomeViewModel) {
        searchResultsTable.reloadData()
    }
    
    func homeDidThrowAnError(model: HomeViewModel, error: String) {
        errorLabel.text = error
    }
}

extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !text.isEmpty else {
            textField.text = ""
            return true
        }
        errorLabel.text = ""
        viewModel.search(term: text)
        return true
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseIdentifier) as? SearchCell else {
            return UITableViewCell.init()
        }
        cell.setBusiness(b: viewModel.searchResults[indexPath.row])
        return cell
    }
}


