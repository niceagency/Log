//
//  Log.swift
//  Ladder
//
//  Created by Wain on 31/07/2015.
//  Copyright (c) 2015 Nice Agency. All rights reserved.
//

import Foundation

/**
 The LogDomain protocol allows for an extensible domain system.
 See `Domain` for the stock provided domains.
 Any domain with a raw value of zero is a common domain that covers all input.
 Any domain with a non-zero raw value is a specific domain which can be used for input suppression.
 */
public protocol LogDomain {
    var rawDomain: Int { get }
}
private func ==(left: LogDomain, right: LogDomain) -> Bool {
    return left.rawDomain == right.rawDomain
}

/**
 Basic implementation of a domain system implementing `LogDomain`.
 
 - Common: The common domain, includes all logged content.
 - Network: The domain for network related content.
 - Model: The domain for data model related content.
 */
public enum Domain: Int, LogDomain {
    case Common = 0
    case Network = -1
    case Model = -2
    
    public var rawDomain: Int {
        return self.rawValue
    }
}

/**
 General purpose logging, offering levels and filtering, and the ability to collect the log for alternate storage / forwarding to other services.
 */
public struct Log {
    /**
     Log level. Higher levels are inclusive of lower levels.
     
     - Debug: The level for debugging or trace information.
     - Warn: The level for warning situations.
     - Error: The level for error situations.
     - None: The level for fatal errors, can also be used for 'always log'.
     */
    public enum Level: Int, CustomStringConvertible {
        case Debug = 3
        case Warn =  2
        case Error = 1
        case None =  0
        
        public var description: String {
            switch(self) {
            case .Debug:
                return "Debug"
            case .Warn:
                return "Warning"
            case .Error:
                return "Error"
            case .None:
                return "No specific level"
            }
        }
    }
    
    /**
     The level at which to output supplied logs.
     Any log input with the specified level or a lower level will be included in the log, and input with a higher level will be suppressed.
     - Default value: .Warn
     */
    public static var logLevel: Level = .Warn
    /**
     The domain for which to output supplied logs.
     - Default value: .Common
     */
    public static var logDomain: LogDomain = Domain.Common
    /**
     Determines if the log prints output to the console or not.
     When not printing to the console any permissible output is still returned from the log function (useful when the log is to be redirected to a file or alternate service).
     - Default value: true
     */
    public static var printLog: Bool = true
    /**
     The date formatter used to timestamp log output.
     - Default value: 'HH:mm:ss.SSSS'
     */
    public static var formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        return formatter
    }()
    
    /**
     Generate log output based on the current level and domain filters.
     The level and domain will be used to filter content and output. Filtered logs will generate an empty string as the output.
     
     - Returns: The formatted log output, or an empty string if the input is filtered.
     
     - Required: 
        - level: The `Level` for the log
        - object: The object to be logged, usually a string or something conforming to `CustomStringConvertible`
     
     - Optional:
        - domain: The `LogDomain` for the log
            - Default value: Domain.Common
        - filename: The name of the source code file which generated the log
            - Default value: #file
        - line: The line number of the source code file which generated the log
            - Default value: #line
        - funcname: The name of the function which generated the log
            - Default value: #function
     */
    public static func log<T>(level: Level, _ object: T, domain: LogDomain = Domain.Common, filename: String = #file, line: Int = #line, funcname: String = #function) -> String
    {
        guard logDomain == Domain.Common || domain == logDomain else { return "" }
        guard level.rawValue <= Log.logLevel.rawValue else { return "" }
        
        let full = "\(formatter.stringFromDate(NSDate())) \(level.description): \((filename as NSString).lastPathComponent) (\(line)) \(funcname) : \(object)"
        
        if printLog {
            print(full)
        }
        
        return full
    }
}
