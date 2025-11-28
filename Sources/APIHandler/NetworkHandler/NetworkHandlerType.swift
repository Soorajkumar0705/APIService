//
//  NetworkHandlerType.swift
//  APIService
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation

//MARK: - NetworkHandlerType

public protocol NetworkHandlerFactoryType {
    
    var logger : NetworkLoggerType { get }
    
    func make() -> NetworkHandlerType
}


public typealias APIResult = (responseData:Data, httpStatusCode:Int)

public protocol NetworkHandlerType {
    
    var logger : NetworkLoggerType { get }
    var requestFactory : RequestBuilderType { get }
    
    func requestDataAPI(
        endpoint : APIEndpointType
        
    )  async throws -> APIResult
}
