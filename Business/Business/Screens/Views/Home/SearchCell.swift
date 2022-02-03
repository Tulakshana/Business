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
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = Style.Font.title.value()
            nameLabel.textColor = Style.Color.text.value()
        }
    }
    @IBOutlet weak var ratingLabel: UILabel! {
        didSet {
            ratingLabel.font = Style.Font.subtitle.value()
        }
    }

   // MARK: -
    
    override func prepareForReuse() {
        thumbView.cancelLoad()
        
        super.prepareForReuse()
    }
    
    // MARK: -
    
    func setBusiness(b: Business) {
        nameLabel.text = b.name
        if let urlString = b.imageURLString, let url = URL.init(string: urlString) {
            thumbView.loadImage(url: url)
        } else {
            thumbView.image = ImageView.placeholder
        }
        ratingLabel.text = ""
        if let rating = b.rating {
            var ratingString = ""
            let numberOfStars = Int.init(rating)
            if numberOfStars > 0 {
                for _ in 0...numberOfStars {
                    ratingString += "\u{2B50}"
                }
            }
            if Double.init(numberOfStars) < rating {
                // Find the unicode character/emoji for half a star and use here
//                ratingString += "\u{2605}"
            }
            ratingLabel.text = ratingString
        }
    }
}
