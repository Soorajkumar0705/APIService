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
    
}

extension APIServiceClient {
    
    public func getData< S : Codable >(
        endpoint : APIEndpointEnumType,
        responseType : S.Type
        
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

            return try responseHandler.parseResponseWithJSONDecoder(data: networkResult.responseData, modelType: responseType)

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
        
    }
    
}

extension APIServiceClient {
    
    public func getDataResult<S: Codable>(
        endpoint: any APIEndpointEnumType,
        responseType: S.Type
        
    ) async -> Result<S, Error>{
        
        if NetworkReachabilityHandler.shared.isNetworkAvailable() == false {
            return .failure(NetworkHandlerError.noInternetConnection)
        }
        
        do{
            let networkResult : APIResult = try await networkHandler.requestDataAPI(endpoint: endpoint.getEndpoint())
            
            if let customHandlingStatusCode, customHandlingStatusCode.contains(networkResult.httpStatusCode),
               delegate != nil
            {
                
                delegate?.didReceiveResponse(with: networkResult.httpStatusCode, data: networkResult.responseData)
            }

            let parsedData = try responseHandler.parseResponseWithJSONDecoder(data: networkResult.responseData, modelType: responseType)
            
            return .success(parsedData)

        }catch let error {
            
            if case let error as NetworkHandlerError = error,
               case let .errorInAPIResponse(errorData: data, statusCode: statusCode) = error,
               let customHandlingStatusCode, customHandlingStatusCode.contains(statusCode),
               delegate != nil
            {
                delegate?.didReceiveResponse(with: statusCode, data: data)
            }
            
            return .failure(error)
        }
        
    }
    
}

extension APIServiceClient {
    
    public func getData<S : Codable>(
        endpoint: any APIEndpointEnumType,
        responseType: S.Type,
        completionHandler: @escaping (Result<S, any Error>) -> Void
        
    ) async {
        
        if NetworkReachabilityHandler.shared.isNetworkAvailable() == false {
            completionHandler(.failure(NetworkHandlerError.noInternetConnection))
            return
        }
        
        do{
            let networkResult : APIResult = try await networkHandler.requestDataAPI(endpoint: endpoint.getEndpoint())
            
            if let customHandlingStatusCode, customHandlingStatusCode.contains(networkResult.httpStatusCode),
               delegate != nil
            {
                delegate?.didReceiveResponse(with: networkResult.httpStatusCode, data: networkResult.responseData)
            }

            let parsedData = try responseHandler.parseResponseWithJSONDecoder(data: networkResult.responseData, modelType: responseType)
            
            completionHandler(.success(parsedData))
            
            return

        }catch let error {
            
            if case let error as NetworkHandlerError = error,
               case let .errorInAPIResponse(errorData: data, statusCode: statusCode) = error,
               let customHandlingStatusCode, customHandlingStatusCode.contains(statusCode),
               delegate != nil
            {
                delegate?.didReceiveResponse(with: statusCode, data: data)
            }
            
            completionHandler(.failure(error))
            return
        }
        
    }
}
