//
//  InfoViewModel.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import Foundation
import RxSwift
import RxRelay


class InfoViewModel {
    
    fileprivate let modelLayer = ModelLayerIMPL()
    fileprivate let bag = DisposeBag()
    
    var volumeID:BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    var title = BehaviorRelay<String?>(value: nil)
    var author = BehaviorRelay<String?>(value: nil)
    var description = BehaviorRelay<String?>(value: nil)
    var imageURL = BehaviorRelay<URL?>(value: nil)
    var error:BehaviorRelay<Error?> = BehaviorRelay<Error?>(value: nil)
    
    init() {
        setupObservables()
    }
    
    private func setupObservables(){
        volumeID.subscribe(onNext: { (volumeID) in
            if let id = volumeID{
                self.modelLayer.getBookDetails(for: id) { bookDetailsObservable in
                    bookDetailsObservable.subscribe(onNext: { (bookInfo,error) in
                        if let info = bookInfo{
                            self.setValues(for: info)
                        }
                        self.error.accept(error)
                    }).disposed(by: self.bag)
                }
            }
        }).disposed(by: self.bag)
    }
    
    private func setValues(for book:BookInfo){
        title.accept(book.volumeInfo.title)
        author.accept(getAuthorString(from: book.volumeInfo.authors))
        description.accept(book.volumeInfo.description ?? "N/A")
        imageURL.accept(URL(string: book.volumeInfo.imageLinks.thumbnail))
    }
    
    private func getAuthorString(from authors:[String]?) -> String{
        if let authors = authors{
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
    
}
