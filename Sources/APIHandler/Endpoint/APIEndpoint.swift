//
//  APIEndpoint.swift
//  APIService
//
//  Created by Suraj kahar on 10/02/25.
//

import Foundation

public struct APIEndpoint : APIEndpointType{
    
    public let baseURL: String
    public let versionURL: String
    public let path: String
    public let method: HTTPMethod
    public let headers : [HTTPHeader]
    public let params: HTTPParamRequestBody?
    
    
    public init(
        baseURL: String,
        versionURL: String,
        path: String,
        method: HTTPMethod,
        headers: [HTTPHeader],
        params: HTTPParamRequestBody?
    ) {
        self.baseURL = baseURL
        self.versionURL = versionURL
        self.path = path
        self.method = method
        self.headers = headers
        self.params = params
    }
    
}
