//
//  APIServiceClient.swift
//  APIService
//
//  Created by Suraj kahar on 09/09/24.
//

import Foundation
import NetworkReachability


//MARK: - APIServiceClient

public class APIServiceClient : NSObject, APIServiceClientType{
    
    public var networkHandler: NetworkHandlerType
    public var responseHandler: ResponseHandlerType
    
    weak public var delegate: APIServiceDelegate?

    
    var authenticationHeader: [HTTPHeader]?
    var customHandlingStatusCode : [Int]?
    
    init(
        networkHandler : NetworkHandlerType,
        responseHandler : ResponseHandlerType,
        delegate : APIServiceDelegate?,
        authenticationHeader : [HTTPHeader]? = nil,
        customHandlingStatusCode : [Int]? = nil
    ){
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
        
        super.init()
        
        self.delegate = delegate
        self.authenticationHeader = authenticationHeader
        self.customHandlingStatusCode = customHandlingStatusCode
        
        NetworkReachabilityHandler.shared.start()
    }
    
    public func getData< S : Codable >(
        endpoint : APIEndpointEnumType,
        successResponseModelType : S.Type
        
    ) async throws -> S {
        
        if NetworkReachabilityHandler.shared.isNetworkAvailable() == false {
            throw NetworkHandlerError.noInternetConnection
        }
        
        do{
            let networkResult : APIResult = try await networkHandler.requestDataAPI(endpoint: endpoint.getEndpoint())
            
            if let customHandlingStatusCode, customHandlingStatusCode.contains(networkResult.httpStatusCode),
               delegate != nil
            {
                
                delegate?.didReceiveResponse(with: networkResult.httpStatusCode, data: networkResult.responseData)
            }

            return try responseHandler.parseResponseWithJSONDecoder(data: networkResult.responseData, modelType: successResponseModelType)

        }catch let error {
            
            if case let error as NetworkHandlerError = error,
               case let .errorInAPIResponse(errorData: data, statusCode: statusCode) = error,
               let customHandlingStatusCode, customHandlingStatusCode.contains(statusCode),
               delegate != nil
            {
                delegate?.didReceiveResponse(with: statusCode, data: data)
            }
            
            throw error
        }
        
    }   // func getData<T:ParsableResponseModel>(endpoint : AuthenticationEndPoint
    
}

