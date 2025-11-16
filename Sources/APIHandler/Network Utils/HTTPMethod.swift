//
//  Enum.swift
//  APIService
//
//  Created by Suraj kahar on 03/01/25.
//

import Foundation


public struct HTTPMethod: RawRepresentable, Equatable, Sendable {
    public let rawValue: String
    public init(rawValue: String) { self.rawValue = rawValue.uppercased() }
}

public extension HTTPMethod {
    static let GET = HTTPMethod(rawValue: "GET")
    static let POST = HTTPMethod(rawValue: "POST")
    static let PUT = HTTPMethod(rawValue: "PUT")
    static let PATCH = HTTPMethod(rawValue: "PATCH")
    static let DELETE = HTTPMethod(rawValue: "DELETE")
}
