//
//  HTTPHeaderUtils.swift
//  APIService
//
//  Created by sooraj kahar on 15/11/25.
//

import Foundation

// Default header fields (extendable)
public extension HTTPHeaderFieldName {
    static let authorization     = HTTPHeaderFieldName("Authorization")
    static let contentType       = HTTPHeaderFieldName("Content-Type")
    static let accept            = HTTPHeaderFieldName("Accept")
    static let acceptEncoding    = HTTPHeaderFieldName("Accept-Encoding")
    static let acceptLanguage    = HTTPHeaderFieldName("Accept-Language")
    static let connection        = HTTPHeaderFieldName("Connection")
}

public extension HTTPHeaderFieldValue {
    static let applicationJson          = HTTPHeaderFieldValue("application/json")
    static let applicationFormURLEncoded = HTTPHeaderFieldValue("application/x-www-form-urlencoded")
    static let multipartFormData        = HTTPHeaderFieldValue("multipart/form-data")
    static let textPlain                = HTTPHeaderFieldValue("text/plain")
    static let applicationXML           = HTTPHeaderFieldValue("application/xml")
    static let applicationQuery         = HTTPHeaderFieldValue("application/query")
    static let wildCard                 = HTTPHeaderFieldValue("*/*")
    
}

public extension HTTPHeader {
    
    func getHeadersForMultipart(paramBody : HTTPParameterType) -> Self {
        guard let paramBody = paramBody as? MultiPartRequestBodyType else {
            return Self(field: .contentType, value: .applicationJson)
        }
        return Self(
            field: .contentType,
            value: HTTPHeaderFieldValue("multipart/form-data; boundary=\(paramBody.boundary)")
        )
    }
    
}
