//
//  HTTPHeader.swift
//  APIService
//
//  Created by Suraj kahar on 10/02/25.
//

import Foundation

public struct HTTPHeaderFieldName: Sendable {
    public let value : String
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct HTTPHeaderFieldValue : Sendable {
    public let value : String
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct HTTPHeader{
    
    public let field: HTTPHeaderFieldName
    public let value: HTTPHeaderFieldValue

    public init(
        field: HTTPHeaderFieldName,
        value: HTTPHeaderFieldValue
    ) {
        self.field = field
        self.value = value
    }
    
}
