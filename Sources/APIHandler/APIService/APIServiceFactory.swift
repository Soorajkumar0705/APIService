//
//  APIServiceFactory.swift
//  iOSModule
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation

class APIServiceFactory{
    
    func makeAPIService() -> APIServiceProtocol {
        APIService(
            networkHandler: NetworkHandlerFactory().make(),
            responseHandler: ResponseHandlerFactory().make()
        )
    }
    
}
