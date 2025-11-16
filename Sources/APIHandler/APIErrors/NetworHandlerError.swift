//
//  NetworkHandlerError.swift
//  APIService
//
//  Created by Suraj kahar on 10/02/25.
//


import Foundation

public enum NetworkHandlerError: APIServiceErrorType, LocalizedError {
    
    case noInternetConnection
    case invalidUrl
    case invalidParameters
    case errorWhileInitiatingRequest
    case errorInAPIRequest
    case unknownHTTPResponseFormat
    case invalidSession
    case errorInAPIResponse(errorData: Data?, statusCode: Int)
    
    case unKnownError
    
    
    public var errorDescription: String? {
        return switch self {
        case .noInternetConnection:
            "No internet connection. Please check your network settings."
        case .invalidUrl:
            "Invalid URL. Please contact support."
        case .invalidParameters:
            "Invalid parameters were provided."
        case .errorWhileInitiatingRequest:
            "Error while initiating the request."
        case .errorInAPIRequest:
            "Error in API response."
        case .unknownHTTPResponseFormat:
            "The server response format is unknown."
            
        case .invalidSession:
            "Invalid session."
        case .errorInAPIResponse(_, statusCode: let statusCode):
            "Error in API response with status code: \(statusCode)."
            
        case .unKnownError:
            "An unknown error occurred."
        }
        
    }
    
    public var recoverySuggestion: String? {
        return switch self {
        case .noInternetConnection:
            "Try reconnecting to Wi-Fi or cellular data and retry the request."
        case .invalidUrl:
            "Check the URL or contact support for assistance."
        case .invalidParameters:
            "Verify the input parameters and try again."
        case .errorWhileInitiatingRequest:
            "Restart the app and try initiating the request again."
        case .errorInAPIRequest:
            "Error While connecting to the server, Please try again."
        case .unknownHTTPResponseFormat:
            "Contact support with the response details."
            
        case .invalidSession:
            "Please sign in and try again."
        case .errorInAPIResponse(_ , statusCode: let statusCode):
            "Error While connecting to the server, Please try again. Status code: \(statusCode)."
            
        case .unKnownError:
            "Restart the app or contact support for assistance."
        }
    }
}
