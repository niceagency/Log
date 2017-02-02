//
//  LogTests.swift
//  LogTests
//
//  Created by Wain on 02/02/2017.
//  Copyright © 2017 Nice Agency. All rights reserved.
//

import XCTest

import Log

extension BasicLogDomain {
    
    static var logStore = Log<BasicLogDomain, BasicLogLevel>(specs: [])
    
    func log<T>(_ level: BasicLogLevel, _ object: T, filename: String = #file, line: Int = #line, funcname: String = #function) {
        let logger = BasicLogDomain.logStore.log(self)
        
        logger.log(level, object, filename: filename, line: line, funcname: funcname)
    }
}

typealias DLog = BasicLogDomain

class LogTests: XCTestCase {
    
    func testExample() {
        var called = false
        
        let assertCalled: (String) -> Void = { log in
            XCTAssert(log.contains("---"))
            
            called = true
        }
        let assertNotCalled: (String) -> Void = { log in
            XCTFail("Should not have been called")
        }
        
        let commonSpec: Log<BasicLogDomain, BasicLogLevel>.LoggerSpec = (domain: .common, level: .debug, logger: assertCalled)
        let networkSpec: Log<BasicLogDomain, BasicLogLevel>.LoggerSpec = (domain: .network, level: .error, logger: assertNotCalled)
        let modelSpec: Log<BasicLogDomain, BasicLogLevel>.LoggerSpec = (domain: .model, level: .debug, logger: assertNotCalled)
        
        DLog.logStore = Log<BasicLogDomain, BasicLogLevel>(specs: [commonSpec, networkSpec, modelSpec])
        
        DLog.common.log(.debug, "--- 1 ---")
        DLog.network.log(.debug, ">>> 2 <<<")
        DLog.network.log(.warn, ">>> 3 <<<")
        
        XCTAssert(called)
    }
}
