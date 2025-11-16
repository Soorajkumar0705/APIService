//
//  HTTPParamRequestBody.swift
//  APIService
//
//  Created by Suraj kahar on 13/03/25.
//

import Foundation

/// httpBody can be accepted as Data or Encodable

public struct HTTPParamRequestBody {
    
    public var body : HTTPParameterType?
    public var cachePolicy: URLRequest.CachePolicy?
    public var timeoutInterval: TimeInterval?
    
    public init(
        body: HTTPParameterType,
        cachePolicy: URLRequest.CachePolicy? = nil,
        timeoutInterval: TimeInterval? = nil
    ){
        self.body = body
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
    }
    
}
