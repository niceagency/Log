//
//  Log.swift
//  Log
//
//  Created by Wain on 31/07/2015.
//  Copyright © 2017 Nice Agency. All rights reserved.
//

import Foundation

/**
 High level logging settings.
 */
public struct Logging {
    /**
     Determines if the loggers print output or not. Applies to all loggers, no matter the domain or level.
     - Default value: true
     */
    public static var isEnabled: Bool = true
    
    /**
     The date formatter used to timestamp log output.
     - Default value: 'HH:mm:ss.SSSS'
     */
    public static var timestampFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        return formatter
    }()
}

public protocol LogDomain: Hashable, CustomStringConvertible {}
public protocol LogLevel: RawRepresentable, Hashable, CustomStringConvertible {}

public typealias ExternalLogger = (String) -> Void

/**
 General purpose collection of loggers, offering levels and filtering, and the ability to collect the log for alternate storage / forwarding to other services.
 */
public struct Log<D: LogDomain, L: LogLevel> where L.RawValue: Comparable {
    
    public typealias LoggerSpec = (domain: D, level: L, logger: ExternalLogger?)
    
    private let loggers: [D:Logger<L>]
    
    public init(specs: [LoggerSpec]) {
        var loggers: [D:Logger<L>] = [:]
        
        for spec in specs {
            loggers[spec.domain] = Logger(logLevel: spec.level, externalLogger: spec.logger)
        }
        
        self.loggers = loggers
    }
    
    /**
     Get a domain specific logger.
     Throws for requests where a domain hasn't been configured with a logger.
     */
    public func log(_ domain: D) -> Logger<L> {
        return self.loggers[domain]!
    }
    
    /**
     Generate a domain specific log output based on the current level.
     The level and domain will be used to filter content and output.
     
     - Required:
     - domain: The log domain
     - level: The `Level` for the log
     - object: The object to be logged, usually a string or something conforming to `CustomStringConvertible`
     
     - Optional:
     - filename: The name of the source code file which generated the log
     - Default value: #file
     - line: The line number of the source code file which generated the log
     - Default value: #line
     - funcname: The name of the function which generated the log
     - Default value: #function
     */
    public func log<T>(_ domain: D, _ level: L, _ object: T, filename: String = #file, line: Int = #line, funcname: String = #function) {
        let logger = self.log(domain)
        
        logger.log(level, object, filename: filename, line: line, funcname: funcname)
    }
}

/**
 General purpose logging, offering levels and respecting broad enabling, and the ability to collect the log for alternate storage / forwarding to other services.
 */
public struct Logger<L: LogLevel> where L.RawValue: Comparable {
    
    /**
     The level at which to output supplied logs.
     Any log input with the specified level or a lower level will be included in the log, and input with a higher level will be suppressed.
     */
    public let logLevel: L
    private let externalLogger: ExternalLogger?
    
    fileprivate init(logLevel: L, externalLogger: ExternalLogger?) {
        self.logLevel = logLevel
        self.externalLogger = externalLogger
    }
    
    /**
     Generate log output based on the current level and domain filters.
     The level and domain will be used to filter content and output.
     
     - Required:
     - level: The `Level` for the log
     - object: The object to be logged, usually a string or something conforming to `CustomStringConvertible`
     
     - Optional:
     - filename: The name of the source code file which generated the log
     - Default value: #file
     - line: The line number of the source code file which generated the log
     - Default value: #line
     - funcname: The name of the function which generated the log
     - Default value: #function
     */
    public func log<T>(_ level: L, _ object: T, filename: String = #file, line: Int = #line, funcname: String = #function)
    {
        guard Logging.isEnabled else { return }
        guard level.rawValue <= self.logLevel.rawValue else { return }
        
        let full = "\(Logging.timestampFormatter.string(from: Date())) \(level.description): \((filename as NSString).lastPathComponent) (\(line)) \(funcname) : \(object)"
        
        if let externalLogger = self.externalLogger {
            externalLogger(full)
        }
        
        print(full)
    }
}
