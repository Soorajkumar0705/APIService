//
//  RequestBuilderType.swift
//  APIService
//
//  Created by Suraj kahar on 02/03/25.
//

import Foundation


public protocol RequestBuilderFactoryType {
    
    var logger: (any NetworkLoggerType) { get }
    
    func make() -> RequestBuilderType
    
}

public protocol RequestBuilderType {
    
    var logger: (any NetworkLoggerType) { get }
    
    func getRequest(for endpoint : APIEndpointType) throws -> URLRequest
    
}
