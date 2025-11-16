//
//  APIEndpointType.swift
//  iOSModule
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
    var params : HTTPParamRequestBody? { get }
    
}
