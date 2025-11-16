//
//  APIEndpointEnumType.swift
//  APIService
//
//  Created by sooraj kahar on 15/11/25.
//

import Foundation

public protocol APIEndpointEnumType {
    
    var baseURL : String { get } // provide default base URL
    var versionURL : String { get } // provide default version URL
    
    func getEndpoint() -> APIEndpointType
    
}

extension APIEndpointEnumType {
    
    func getSessionTokenHeader() -> HTTPHeader {
        let fieldName = "x-session-token"
        let value = "" // AuthenticationHandler.shared.sessionToken
#warning("Fix this")
        
        return HTTPHeader(
            field: HTTPHeaderFieldName(fieldName),
            value: HTTPHeaderFieldValue(value)
        )
    }
    
}
