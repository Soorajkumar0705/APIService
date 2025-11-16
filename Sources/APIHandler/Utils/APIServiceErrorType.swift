//
//  APIServiceErrorType.swift
//  APIService
//
//  Created by sooraj kahar on 15/11/25.
//

import Foundation

protocol APIServiceErrorType : Error, LocalizedError, NameLoggable{
    func log()
}

extension APIServiceErrorType {
    func log() {
        print("[\(className)] : \(errorDescription ?? "No error description"), Recovery Suggestion: \(recoverySuggestion ?? "No recovery suggestion")")
    }
}
