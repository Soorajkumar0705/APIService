//
//  APIService.swift
//  iOSModule
//
//  Created by Suraj kahar on 09/09/24.
//

import Foundation


//MARK: - APIService

public class APIService : NSObject, APIServiceProtocol{
    
    var networkHandler: NetworkHandlerType
    var responseHandler: ResponseHandlerType
    
    
    public init(networkHandler : NetworkHandlerType,
         responseHandler : ResponseHandlerType
    ){
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
    
    public func getData< S : Codable >(
        endpoint : APIEndpointEnumType,
        useCustomParser : Bool = false,
        successResponseModelType : S.Type
        
    ) async throws -> S {
        
        do{
            let networkResult = try await networkHandler.requestDataAPI(endpoint: endpoint.getEndpoint())
            
            return try responseHandler.parseResponseWithJSONDecoder(data: networkResult, modelType: successResponseModelType)

        }catch let error {
            
            if case let error as NetworkHandlerError = error,
               case let .errorInAPIResponse(errorData: data, statusCode: statusCode) = error
            {
                #warning("Fix this using builder pattern")
                
            }
            
            throw error
        }
        
    }   // func getData<T:ParsableResponseModel>(endpoint : AuthenticationEndPoint
    
}

