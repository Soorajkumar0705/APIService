//
//  NetworkHandler.swift
//  APIService
//
//  Created by Suraj kahar on 02/01/25.
//

import Foundation


class NetworkHandlerFactory : NetworkHandlerFactoryType{
    
    func make() -> NetworkHandlerType {
        NetworkHandler(
            requestFactory: RequestBuilderFactory().make()
        )
    }
    
}

class NetworkHandler : NetworkHandlerType {
    
    var requestFactory: RequestBuilderType
    
    init(
        requestFactory: RequestBuilderType
    ){
        self.requestFactory = requestFactory
    }

    func requestDataAPI(
        endpoint : APIEndpointType
        
    )  async throws -> APIResult {

        var req = try requestFactory.getRequest(for: endpoint)

        let (data, httpResponse) = try await URLSession.shared.data(for: req)
        
        
        print("URL : ", req.url?.absoluteString as Any)
        print("URL Response : ", data.toJSON() as Any)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            throw NetworkHandlerError.unknownHTTPResponseFormat
        }
        
        if (200...300).contains(httpResponse.statusCode){
            return (responseData: data, httpStatusCode: httpResponse.statusCode)
        }else{
            throw NetworkHandlerError.errorInAPIResponse(errorData: data, statusCode: httpResponse.statusCode)
        }
    }

}
