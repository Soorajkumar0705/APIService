//
//  NetworkLoggerType.swift
//  APIService
//
//  Created by sooraj kahar on 28/11/25.
//

import OSLog

public protocol NetworkLoggerType {
    
    var subsystem : String { get }
    var category : String { get }
    
    var logLevel: OSLogType { get set }
    var logger : OSLog { get }

    
    func log(_ message : Any...)
    func log(_ message: String)
    
}
