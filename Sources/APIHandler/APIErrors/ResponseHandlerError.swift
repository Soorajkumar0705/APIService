//
//  ResponseHandlerError.swift
//  APIService
//
//  Created by Suraj kahar on 10/02/25.
//


import Foundation

public enum ResponseHandlerError: APIServiceErrorType {
    
    case responseTypeIsNotInCodableFormat
    case errorWhileDecodingResponse(_ error : Error)
    
    public var errorDescription: String? {
        switch self {
            
        case .errorWhileDecodingResponse(let error):
            "Error while decoding response: \(error.localizedDescription)"
            
        case .responseTypeIsNotInCodableFormat:
            "The response type is not in a codable format."
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
            
        case .errorWhileDecodingResponse:
            "Review the decoding process and ensure the response data matches the expected format."
        case .responseTypeIsNotInCodableFormat:
            "Check the response model and ensure it conforms to the Codable protocol."
        }
    }
    
}
