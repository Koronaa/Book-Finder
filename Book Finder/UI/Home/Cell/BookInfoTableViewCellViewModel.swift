//
//  BookInfoTableViewCellViewModel.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import Foundation
import RxSwift

class BookInfoTableViewCellViewModel{
    
    var item:Item
    
    init(item:Item) {
        self.item = item
    }
    
    var title:String{
        item.volumeInfo.title
    }
    
    var imageURL:URL{
        URL(string: item.volumeInfo.imageLinks.thumbnail)!
    }
    
    var author:String{
        if let authors = item.volumeInfo.authors{
            if authors.count == 0{
                return "N/A"
            }else if authors.count == 1{
                return authors.first!
            }else{
                return authors.joined(separator: ",")
            }
        }
        return "N/A"
    }
    
    var subTitle:String{
        if let subTitle = item.volumeInfo.subtitle{
            return subTitle
        }
        return "N/A"
    }
    
}
