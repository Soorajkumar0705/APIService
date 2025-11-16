//
//  HTTPParameterType.swift
//  APIService
//
//  Created by sooraj kahar on 15/11/25.
//

import Foundation


public struct HTTPParameter {
    
    public var body : Data?
    
    private var jsonBody : Encodable?
    private var multipartBody : MultiPartRequestBodyType?
    
    
    public init?(body : Data?) {
        self.body = body
    }
    
    public init?(body : Encodable) {
        self.jsonBody = body
    }
    
    public init?(body : MultiPartRequestBodyType) {
        self.multipartBody = body
    }
    
    public func buildBody() -> Data? {
        
        if let dataBody = self.body {
            return dataBody
        }
        
        if let jsonBody, let encodedBody = try? JSONEncoder().encode(jsonBody) {
            return encodedBody
        }
        
        if let multipartBody = self.multipartBody {
            return multipartBody.buildMultiPartBodyBuilder().build()
        }
        
        return nil
    }
    
}

public protocol MultiPartRequestBodyType: Encodable {
    var boundary: String { get }
    func buildMultiPartBodyBuilder() -> MultipartFormDataBodyBuilder
}

