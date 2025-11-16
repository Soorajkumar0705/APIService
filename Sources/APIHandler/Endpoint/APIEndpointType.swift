//
//  APIEndpointType.swift
//  APIService
//
//  Created by Suraj kahar on 02/01/25.
//

import Foundation


public protocol APIEndpointType {
    
    var baseURL: String { get }
    var versionURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers : [HTTPHeader] { get }
    var parameter : HTTPParameter? { get }
    var configurations : [APIConfiguration] { get }
    
}


public enum APIConfiguration {
    case cachePolicy(URLRequest.CachePolicy)
    case timeoutInterval(TimeInterval)
}
