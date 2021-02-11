//
//  ServiceManager.swift
//  Book Finder
//
//  Created by Sajith Konara on 2021-02-11.
//

import Foundation
import Alamofire
import RxSwift

protocol ServiceManager {
    typealias onAPIRxResponse = (_ observable:Observable<(Data?,Int)>)->()
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters?,onResponse:@escaping onAPIRxResponse)
}

class ServiceManagerIMPL:ServiceManager{
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters? = nil,onResponse: @escaping onAPIRxResponse){
        
        if ReachabilityManager.isConnectedToNetwork(){
            AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { response in
                if let statusCode = response.response?.statusCode {
                    onResponse(Observable.just((response.data,statusCode)))
                }
            }
        }else{
            onResponse(Observable.just((nil,999)))
        }
    }
}
