//
//  HomeViewModel.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel{
    
    fileprivate let modelLayer:ModelLayer = ModelLayerIMPL()
    fileprivate let bag = DisposeBag()
    
    var searchedQuery:BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    var items:BehaviorRelay<[Item]> = BehaviorRelay<[Item]>(value: [])
    var error:BehaviorRelay<Error?> = BehaviorRelay<Error?>(value: nil)
    
    let itemLimit = 10
    var currentPage:Int = 0
    var totalItems:Int = 0
    
    var numbeOfCells:Int{
        return items.value.count
    }
    
    init() {
        setupObservables()
    }
    
    private func setupObservables(){
        searchedQuery.subscribe(onNext: { (query) in
            if let query = query{
                self.searchBooks(for:query)
            }
        }).disposed(by: self.bag)
    }
    
    
    private func searchBooks(for query:String){
        modelLayer.searchBooks(for: query, pageNo: currentPage, limit: itemLimit) { (observable) in
            observable.subscribe(onNext: { (result,error) in
                if let res = result{
                    self.totalItems = res.totalItems
                    self.items.accept(self.items.value + res.items)
                }
                self.error.accept(error)
            }).disposed(by: self.bag)
        }
    }
    
     func getTotalPages()->Int{
        return Int(ceil(Double(totalItems/itemLimit)))
    }
    
    func loadNextPage(){
        if currentPage < getTotalPages(){
            currentPage += 1
            searchBooks(for: searchedQuery.value!)
        }
    }
    
    func resetSearch(){
        currentPage = 0
        totalItems = 0
        items.accept([])
    }
    
   
    
}


