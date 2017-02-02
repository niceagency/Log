//
//  BasicLog.swift
//  Log
//
//  Created by Wain on 02/02/2017.
//  Copyright © 2017 Nice Agency. All rights reserved.
//

import Foundation

/**
 Example basic implementation of a domain system.
 
 - Common: The common domain, includes all logged content.
 - Network: The domain for network related content.
 - Model: The domain for data model related content.
 */
public enum BasicLogDomain: Int, LogDomain {
    case common = 0
    case network = -1
    case model = -2
    
    public var description: String {
        switch(self) {
        case .common:
            return "Common"
        case .network:
            return "Network"
        case .model:
            return "Model"
        }
    }
}

/**
 Example basic implementation of log level system. Higher levels are inclusive of lower levels.
 
 - Debug: The level for debugging or trace information.
 - Warn: The level for warning situations.
 - Error: The level for error situations.
 - None: The level for fatal errors, can also be used for 'always log'.
 */
public enum BasicLogLevel: Int, LogLevel {
    case trace = 4
    case debug = 3
    case warn =  2
    case error = 1
    case none =  0
    
    public var description: String {
        switch(self) {
        case .trace:
            return "Trace"
        case .debug:
            return "Debug"
        case .warn:
            return "Warning"
        case .error:
            return "Error"
        case .none:
            return "No specific level"
        }
    }
}
