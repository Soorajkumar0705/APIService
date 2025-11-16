//
//  ResponseHandler.swift
//  APIService
//
//  Created by Suraj kahar on 02/01/25.
//

import Foundation


class ResponseHandlerFactory{
    
    func make() -> ResponseHandlerType{
        ResponseHandler(jsonDecoder: JSONDecoder())
    }
    
}

class ResponseHandler : ResponseHandlerType{
    
    var jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func parseResponseWithJSONDecoder<T : Codable>(
        data: Data,
        modelType: T.Type
    ) throws -> T {
        
        do {
            return try jsonDecoder.decode(modelType, from: data)
        } catch{
            throw ResponseHandlerError.responseTypeIsNotInCodableFormat
        }
        
    }
    
}
