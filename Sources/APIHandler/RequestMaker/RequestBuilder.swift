//
//  RequestBuilder.swift
//  APIService
//
//  Created by Suraj kahar on 22/01/25.
//

import Foundation


class RequestBuilderFactory : RequestBuilderFactoryType{
    
    public var logger: (any NetworkLoggerType)
    
    init(logger: any NetworkLoggerType) {
        self.logger = logger
    }
    
    func make() -> RequestBuilderType {
        RequestBuilder(
            logger: logger
        )
    }
    
}


class RequestBuilder : RequestBuilderType{
    
    public var logger: (any NetworkLoggerType)
    
    init(logger: any NetworkLoggerType) {
        self.logger = logger
    }
    
    func getRequest(for endpoint : APIEndpointType) throws -> URLRequest {
        
        let urlString = endpoint.baseURL + endpoint.versionURL + endpoint.path
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString)
        else {
            throw NetworkHandlerError.invalidUrl
        }
        
        
        var request = URLRequest(url: url)
        
        for configuration in endpoint.configurations {
            switch configuration {
                
            case .cachePolicy(let cachePolicy):
                request.cachePolicy = cachePolicy
            case .timeoutInterval(let timeInterval):
                request.timeoutInterval = timeInterval
            }
        }
        
        if let body = endpoint.parameter?.buildBody(){
            request.httpBody = body
        }
        
        request.httpMethod = endpoint.method.rawValue
        
        // SET HEADERS
        
        for header in (endpoint.headers) {
            request.addValue(header.value.value, forHTTPHeaderField: header.field.value)
        }
        
        logger.log("* ================ * APIService * ================ *")
        logger.log("URL : \(url.absoluteString)")
        logger.log("HTTPMethod : \(endpoint.method as Any)")
        logger.log("HTTP Header fields : \(request.allHTTPHeaderFields ?? [:])")
        logger.log("EndPoint Configuration : \(endpoint.configurations)")
        logger.log("HTTPParameter : \(endpoint.parameter as Any)")
        
        return request
    }
    
}
