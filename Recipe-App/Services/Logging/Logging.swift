//
//  Logging.swift
//  Recipe-App
//
//  Created by Hassan on 14/01/25.
//

import os.log
import Foundation

enum LogLevel {
    case debug
    case info
    case warning
    case error
}

final class LoggingService {
    
    private let logger = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "com.hassanvfx.app", category: "Application")
    
    public init() {} // Prevent external initialization
    
    func debug(_ message: String) {
        os_log("DEBUG: %@", log: logger, type: .debug, message)
    }
    
    func info(_ message: String) {
        os_log("INFO: %@", log: logger, type: .info, message)
    }
    
    func warning(_ message: String) {
        os_log("WARNING: %@", log: logger, type: .default, message)
    }
    
    func error(_ message: String) {
        os_log("ERROR: %@", log: logger, type: .error, message)
    }
}
