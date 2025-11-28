//
//  NetworkHandler.swift
//  APIService
//
//  Created by Suraj kahar on 02/01/25.
//

import Foundation


class NetworkHandlerFactory : NetworkHandlerFactoryType{
    
    var logger : NetworkLoggerType
    
    init(logger: NetworkLoggerType) {
        self.logger = logger
    }
    
    func make() -> NetworkHandlerType {
        NetworkHandler(
            logger: logger,
            requestFactory: RequestBuilderFactory(
                logger: logger
            ).make()
        )
    }
    
}

class NetworkHandler : NetworkHandlerType {
    
    var logger: any NetworkLoggerType
    var requestFactory: RequestBuilderType
    
    init(
        logger : NetworkLoggerType,
        requestFactory: RequestBuilderType
    ){
        self.logger = logger
        self.requestFactory = requestFactory
    }

    func requestDataAPI(
        endpoint : APIEndpointType
        
    )  async throws -> APIResult {

        let req = try requestFactory.getRequest(for: endpoint)

        let (data, httpResponse) = try await URLSession.shared.data(for: req)
        
        logger.log("URL : \(req.url?.absoluteString as Any)")
        logger.log("URL Response : \(data.toJSON() as Any)")
        
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
