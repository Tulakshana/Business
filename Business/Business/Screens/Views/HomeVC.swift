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
            let attribString = NSMutableAttributedString.init(string: NSLocalizedString("placeholder_search", comment: "Type in what you are looking for"))
            attribString.addAttributes([NSAttributedString.Key.font: Style.Font.paragraph.value()], range: NSMakeRange(0, attribString.length))
            attribString.addAttributes([NSAttributedString.Key.foregroundColor: Style.Color.placeholder.value()], range: NSMakeRange(0, attribString.length))
            searchTextField.attributedText = attribString
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
