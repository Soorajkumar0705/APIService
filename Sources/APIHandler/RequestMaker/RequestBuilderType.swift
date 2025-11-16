//
//  RequestBuilderType.swift
//  APIService
//
//  Created by Suraj kahar on 02/03/25.
//

import Foundation


public protocol RequestBuilderFactoryType {
    
    func make() -> RequestBuilderType
    
}

public protocol RequestBuilderType {
    
    func getRequest(for endpoint : APIEndpointType) throws -> URLRequest
    
}
