//
//  URLConstants.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import Foundation

struct URLConstants {
    
    struct Api {
        static let HOST = "https://www.googleapis.com/books/v1/"
        
        struct Path {
            
            static var searchBooks:String{
                return HOST + "volumes?q=%@&startIndex=%@&maxResults=%@"
            }
            
            static var getBookDetails:String{
                return HOST + "volumes/%@"
            }
        }
    }
}
