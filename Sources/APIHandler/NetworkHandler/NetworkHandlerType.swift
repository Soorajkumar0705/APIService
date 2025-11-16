//
//  NetworkHandlerType.swift
//  APIService
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation

//MARK: - NetworkHandlerType

public protocol NetworkHandlerFactoryType {
    func make() -> NetworkHandlerType
}

public protocol NetworkHandlerType {
    
    var requestFactory : RequestBuilderType { get }
    
    func requestDataAPI(
        endpoint : APIEndpointType
        
    )  async throws -> Data
}
