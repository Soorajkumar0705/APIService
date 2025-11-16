//
//  HTTPParameterType.swift
//  APIService
//
//  Created by sooraj kahar on 15/11/25.
//

import Foundation


public protocol HTTPParameterType {
    var body : Data? { get set }
}

public struct HTTPParameter : HTTPParameterType {
    
    public var body : Data?
    
    private var jsonBody : JsonRequestBodyType?
    private var multipartBody : MultiPartRequestBodyType?
    
    
    public init (body : Data?) {
        self.body = body
    }
    
    init?(body : JsonRequestBodyType) {
        self.jsonBody = body
    }
    
    init?(multipartBody : MultiPartRequestBodyType) {
        self.multipartBody = multipartBody
    }
    
    public func buildBody() -> Data? {
        
        if let dataBody = self.body {
            return dataBody
        }
        
        if let encodedBody = try? JSONEncoder().encode(body) {
            return encodedBody
        }
        
        if let multipartBody = self.multipartBody {
            return self.multipartBody?.buildMultiPartBodyBuilder().build()
        }
        
        return nil
    }
    
}

public protocol JsonRequestBodyType: Encodable, HTTPParameterType {
    func toJson() -> StringAnyDict
}


public protocol MultiPartRequestBodyType: Encodable, HTTPParameterType {
    var boundary: String { get }
    func buildMultiPartBodyBuilder() -> MultipartFormDataBodyBuilder
}

