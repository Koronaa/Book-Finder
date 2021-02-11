//
//  TranslationLayer.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import Foundation
import RxSwift

class TranslationLayer{
    
    func getSearchResults(from responseData:Data,onCompleted: @escaping (_ observable:Observable<(searchResult:SearchResult?,error:Error?)>)->Void){
        let decorder = JSONDecoder()
        do{
            let searchResponse = try decorder.decode(SearchResult.self, from: responseData)
            onCompleted(Observable.just((searchResponse,nil)))
        }catch(let e){
            let error = Error(title: "Translation Error!", message: "Something went wrong while translating data.")
            onCompleted(Observable.just((nil,error)))
            print(e.localizedDescription)
        }
    }
    
    func getBookInfo(from responseData:Data,onCompleted: @escaping (_ observable:Observable<(bookInfo:BookInfo?,error:Error?)>)->Void){
        let decorder = JSONDecoder()
        do{
            let bookResponse = try decorder.decode(BookInfo.self, from: responseData)
            onCompleted(Observable.just((bookResponse,nil)))
        }catch(let e){
            let error = Error(title: "Translation Error!", message: "Something went wrong while translating data.")
            onCompleted(Observable.just((nil,error)))
            print(e.localizedDescription)
        }
    }
    
}
