//
//  SearchCell.swift
//  Business
//
//  Created by Tulakshana Weerasooriya on 2022-02-03.
//

import UIKit

class SearchCell: UITableViewCell {
    
    static let nibName = "SearchCell"
    static let reuseIdentifier = "SearchCellIdentifier"
    
    // MARK: -
    
    @IBOutlet weak var thumbView: ImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

   // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.font = Style.Font.title.value()
        nameLabel.textColor = Style.Color.text.value()
    }
    
    override func prepareForReuse() {
        thumbView.cancelLoad()
        
        super.prepareForReuse()
    }
    
    // MARK: -
    
    func setBusiness(b: Business) {
        nameLabel.text = b.name
        if let urlString = b.imageURLString, let url = URL.init(string: urlString) {
            thumbView.loadImage(url: url)
        }
    }
}
