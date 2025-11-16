//
//  RequestBuilder.swift
//  iOSModule
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
        
        if let params = endpoint.params{
            try handleParamBody(request: &request, params: params)
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


fileprivate extension RequestBuilder {
    
    func handleParamBody(request : inout URLRequest, params : HTTPParamRequestBody) throws {
        
        if let cachePolicy = params.cachePolicy { request.cachePolicy = cachePolicy }
        request.timeoutInterval = params.timeoutInterval ?? 30
        
        if let body = params.body?.body {
            
        }
        
        switch params.body {
            
        case let body as MultiPartRequestBodyType:
            request.httpBody = body.buildMultiPartBodyBuilder().build()
            
        case let params as JsonRequestBodyType:
            guard let httpBody = try? JSONSerialization.data(
                withJSONObject: params.toJson(),
                options: [] ) else {
                throw NetworkHandlerError.invalidParameters
            }
            
            request.httpBody = httpBody
            
            print("URL Request : ", params.toJson())
            
        case let body as Data:
            request.httpBody = body
            
        case let body as Encodable:
            if let httpBody = try? JSONEncoder().encode(body) {
                request.httpBody = httpBody
            }
            
        default:
            break;
            
        }
        
    } // func handleParamBody(request : inout URLRequest, params : HTTPParam)
    
}
