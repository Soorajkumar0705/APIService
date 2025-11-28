//
//  APIServiceClientType.swift
//  APIService
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation

//MARK: -  APIServiceProtocol

public protocol APIServiceClientType: NSObjectProtocol {
    
    var logger: NetworkLoggerType { get set }
    var networkHandler : NetworkHandlerType { get }
    var responseHandler : ResponseHandlerType { get }
    
    
    var delegate: APIServiceDelegate? { get set }
    
    
    func getData< S : Codable>(
        endpoint : APIEndpointEnumType,
        successResponseModelType : S.Type
        
    ) async throws -> S
    
}

public protocol APIServiceDelegate: AnyObject {
    func didReceiveResponse(with statusCode : Int, data : Data?, forEndPoint : APIEndpointEnumType)
}
