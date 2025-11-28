//
//  APIServiceClientFactory.swift
//  APIService
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation


public class APIServiceClientFactory{
    
    var logger: NetworkLoggerType?
    var networkHandler: NetworkHandlerType?
    var responseHandler: ResponseHandlerType?
    
    var jsonDecoder : JSONDecoder?
    
    var authenticationHeader: [HTTPHeader]?
    var customHandlingStatusCode : [Int]?
    
    weak var delegate: APIServiceDelegate?
    
    public init() {
    }
    
    
    public func setLogger(_ logger : NetworkLoggerType) -> Self {
        self.logger = logger
        return self
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
    
    public func setJsonDecoder(_ jsonDecoder: JSONDecoder) -> Self {
        self.jsonDecoder = jsonDecoder
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

        let logger = logger ?? NetworkLoggerFactory(logLevel: .debug).make()
        let jsonDecoder = jsonDecoder ?? JSONDecoder()
        
        let networkHandler = networkHandler ?? NetworkHandlerFactory(
            logger: logger
        ).make()
        
        let responseHandler = responseHandler ?? ResponseHandlerFactory(
            logger: logger,
            jsonDecoder: jsonDecoder
        ).make()
        
        return APIServiceClient(
            logger: logger,
            networkHandler: networkHandler,
            responseHandler: responseHandler,
            delegate: delegate,
            authenticationHeader: authenticationHeader,
            customHandlingStatusCode: customHandlingStatusCode
        )
    }
    
}
