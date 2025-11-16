//
//  RequestBuilder.swift
//  APIService
//
//  Created by Suraj kahar on 22/01/25.
//

import Foundation


class RequestBuilderFactory : RequestBuilderFactoryType{
    
    func make() -> RequestBuilderType {
        RequestBuilder()
    }
    
}


class RequestBuilder : RequestBuilderType{
    
    func getRequest(for endpoint : APIEndpointType) throws -> URLRequest {
        
        let urlString = endpoint.baseURL + endpoint.versionURL + endpoint.path
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString)
        else {
            throw NetworkHandlerError.invalidUrl
        }
        
        print("URL : ", url.absoluteString)
        
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
        
        print("URL Request Headers : ", request.allHTTPHeaderFields ?? [:] )
        
        return request
    }
    
}
