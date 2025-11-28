//
//  ResponseHandlerType.swift
//  APIService
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation


public protocol ResponseHandlerFactoryType {
    
    var logger : NetworkLoggerType { get }
    var jsonDecoder: JSONDecoder { get }
    
    func make() -> ResponseHandlerType
}

//MARK: - ResponseHandlerType

public protocol ResponseHandlerType {
    
    var logger : NetworkLoggerType { get }
    var jsonDecoder: JSONDecoder { get }
    
    func parseResponseWithJSONDecoder<T: Codable>(
        data: Data,
        modelType: T.Type
    ) throws -> T
    
}
