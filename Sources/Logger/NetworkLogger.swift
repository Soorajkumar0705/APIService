//
//  NetworkLogger.swift
//  APIService
//
//  Created by sooraj kahar on 28/11/25.
//

import Foundation
import OSLog

class NetworkLoggerFactory {
    
    var logLevel : OSLogType
    
    init(logLevel: OSLogType) {
        self.logLevel = logLevel
    }
    
    func make() -> NetworkLoggerType {
        NetworkLogger(
            logLevel: logLevel
        )
    }
}

class NetworkLogger : NetworkLoggerType{

    internal let subsystem = "com.apiservice.network"
    internal let category = "api"

    var logLevel : OSLogType
    var logger : OSLog
    

    init(logLevel: OSLogType = .debug) {
        self.logLevel = logLevel
        self.logger = OSLog(subsystem: subsystem, category: category)
    }
    
    func log(_ message : Any...) {
        // Create a print-style string
        let message = message.map { "\($0)" }.joined(separator: " ")
        log(message)
    }
    
    func log(_ message: String) {
        os_log(
            "%{public}@",
            log: logger,
            type: logLevel,
            message
        )
    }
    
}
