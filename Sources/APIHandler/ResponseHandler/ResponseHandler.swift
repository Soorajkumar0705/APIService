//
//  ResponseHandler.swift
//  APIService
//
//  Created by Suraj kahar on 02/01/25.
//

import Foundation


class ResponseHandlerFactory{
    
    var logger : NetworkLoggerType
    var jsonDecoder : JSONDecoder
    
    init(
        logger: NetworkLoggerType,
        jsonDecoder : JSONDecoder
    ) {
        self.logger = logger
        self.jsonDecoder = jsonDecoder
    }
    
    func make() -> ResponseHandlerType{
        ResponseHandler(
            logger: logger,
            jsonDecoder: jsonDecoder
        )
    }
    
}

class ResponseHandler : ResponseHandlerType{
    
    var logger: any NetworkLoggerType
    var jsonDecoder: JSONDecoder
    
    init(
        logger : any NetworkLoggerType,
        jsonDecoder: JSONDecoder
    ) {
        self.logger = logger
        self.jsonDecoder = jsonDecoder
    }
    
    func parseResponseWithJSONDecoder<T : Codable>(
        data: Data,
        modelType: T.Type
    ) throws -> T {
        
        return try jsonDecoder.decode(modelType, from: data)
        
    }
    
}
