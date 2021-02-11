//
//  ModelLayer.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import Foundation
import RxSwift

typealias SearchResultResponseBlock = (Observable<(SearchResult?,Error?)>)->Void
typealias BookInfoResponseBlock = (Observable<(BookInfo?,Error?)>)->Void

protocol ModelLayer {
    func searchBooks(for query:String,pageNo:Int,limit:Int,onCompleted:@escaping SearchResultResponseBlock)
    func getBookDetails(for volumeID:String,onCompleted:@escaping BookInfoResponseBlock)
}


class ModelLayerIMPL:ModelLayer{
    
    fileprivate let networkLayer:NetworkLayerIMPL = NetworkLayerIMPL()
    fileprivate let translationLayer:TranslationLayer = TranslationLayer()
    fileprivate let bag = DisposeBag()
    
    //TODO: DI
    //    init(networkLayer:NetworkLayerIMPL,translationLayer:TranslationLayer) {
    //        self.networkLayer = networkLayer
    //        self.translationLayer = translationLayer
    //    }
    
    func searchBooks(for query: String, pageNo: Int, limit: Int, onCompleted: @escaping SearchResultResponseBlock) {
        let url = URL(string: String(format: URLConstants.Api.Path.searchBooks, query,pageNo.description,limit.description).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        networkLayer.getResponseJSON(for: url) { dataObservable in
            dataObservable.subscribe(onNext: { (data,errot) in
                if let responseData = data{
                    self.translationLayer.getSearchResults(from: responseData) { (searchResponseOnservable) in
                        searchResponseOnservable.subscribe(onNext: { (searchResult,error) in
                            if let searchInfo = searchResult{
                                onCompleted(Observable.just((searchInfo,nil)))
                            }else{
                                onCompleted(Observable.just((nil,error)))
                            }
                        }).disposed(by: self.bag)
                    }
                }
            }).disposed(by: self.bag)
        }
    }
    
    func getBookDetails(for volumeID: String, onCompleted: @escaping BookInfoResponseBlock) {
        let url = URL(string: String(format: URLConstants.Api.Path.getBookDetails, volumeID).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        networkLayer.getResponseJSON(for: url) { (dataObservable) in
            dataObservable.subscribe(onNext: { (data,error) in
                if let responseData = data{
                    self.translationLayer.getBookInfo(from: responseData) { (bookInfoObservable) in
                        bookInfoObservable.subscribe(onNext: { (bookInfoResponse,error) in
                            if let bookInfo = bookInfoResponse{
                                onCompleted(Observable.just((bookInfo,nil)))
                            }else{
                                onCompleted(Observable.just((nil,error)))
                            }
                        }).disposed(by: self.bag)
                    }
                }
            }).disposed(by: self.bag)
        }
    }
}

