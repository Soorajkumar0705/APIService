//
//  APIServiceFactory.swift
//  APIService
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation


public class APIServiceFactory{
    
    var networkHandler: NetworkHandlerType?
    var responseHandler: ResponseHandlerType?
    
    var authenticationHeader: [HTTPHeader]?
    var customHandlingStatusCode : [Int]?
    
    weak var delegate: APIServiceDelegate?
    
    public init() {
    }
    
    
    public func setNetworkhandler(_ networkHandler: NetworkHandlerType) -> Self {
        self.networkHandler = networkHandler
        return self
    }
    
    public func setResponseHandler(_ responseHandler: ResponseHandlerType) -> Self {
        self.responseHandler = responseHandler
        return self
    }
    
    public func setAuthenticationHeader(_ authenticationHeader: [HTTPHeader]) -> Self {
        self.authenticationHeader = authenticationHeader
        return self
    }
    
    public func setCustomHandlingStatusCode(_ customHandlingStatusCode: [Int]) -> Self {
        self.customHandlingStatusCode = customHandlingStatusCode
        return self
    }
    
    public func setDelegate(_ delegate: APIServiceDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    
    public func make() -> APIServiceClientType {
        APIServiceClient(
            networkHandler: networkHandler ?? NetworkHandlerFactory().make(),
            responseHandler: responseHandler ?? ResponseHandlerFactory().make(),
            delegate: delegate,
            authenticationHeader: authenticationHeader,
            customHandlingStatusCode: customHandlingStatusCode
        )
    }
    
}
