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
        }
    }
    
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.font = Style.Font.paragraph.value()
            infoLabel.textColor = Style.Color.error.value()
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

    // MARK: -
    
    @objc private func didReceiveDidBecomeActiveNotification(notification: Notification) {
        infoLabel.text = ""
        viewModel.startLocationService()
    }

}

extension HomeVC: HomeDelegate {
    func homeDidThrowAnError(model: HomeViewModel, error: HomeViewModel.Error) {
        infoLabel.text = error.message()
    }
}
