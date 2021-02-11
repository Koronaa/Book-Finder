//
//  BookInfoTableViewCell.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import UIKit
import Kingfisher

class BookInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var bookInfoTableViewCellVM:BookInfoTableViewCellViewModel!{
        didSet{
            bookImageView.kf.setImage(with: bookInfoTableViewCellVM.imageURL)
            titleLabel.text = bookInfoTableViewCellVM.title
            authorLabel.text = bookInfoTableViewCellVM.author
            descriptionLabel.text = bookInfoTableViewCellVM.subTitle
        }
    }
}
