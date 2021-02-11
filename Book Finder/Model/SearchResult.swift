//
//  SearchResult.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import Foundation


struct SearchResult : Codable {
    let totalItems: Int
    let items: [Item]
}


struct Item: Codable {
    let id: String
    let volumeInfo: VolumeInfo
}


struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let imageLinks: ImageLinks
    let subtitle: String?
    let description:String?
}


struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}
