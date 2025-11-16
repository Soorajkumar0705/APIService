//
//  ResponseHandlerType.swift
//  iOSModule
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation


public protocol ResponseHandlerFactoryType {
    func make() -> ResponseHandlerType
}

//MARK: - ResponseHandlerType

public protocol ResponseHandlerType {
    
    func parseResponseWithJSONDecoder<T: Codable>(
        data: Data,
        modelType: T.Type
    ) throws -> T
    
}
