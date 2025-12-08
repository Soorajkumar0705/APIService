//
//  APIServiceClientType.swift
//  APIService
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation

//MARK: -  APIServiceProtocol

public protocol APIServiceClientType: NSObjectProtocol {
    
    var networkHandler : NetworkHandlerType { get }
    var responseHandler : ResponseHandlerType { get }
    
    
    var delegate: APIServiceDelegate? { get set }
    
    
    func getData< S : Codable>(
        endpoint : APIEndpointEnumType,
        responseType : S.Type
        
    ) async throws -> S
    
    func getDataResult< S : Codable>(
        endpoint : APIEndpointEnumType,
        responseType : S.Type
        
    ) async -> Result<S, Error>
    
    func getData< S : Codable>(
        endpoint : APIEndpointEnumType,
        responseType : S.Type,
        completionHandler : @escaping (Result<S, Error>) -> Void
    ) async
    
}

public protocol APIServiceDelegate: AnyObject {
    func didReceiveResponse(with statusCode : Int, data : Data?)
}
