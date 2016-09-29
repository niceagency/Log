//
//  LogTests.swift
//  LogTests
//
//  Created by Wain on 18/04/2016.
//  Copyright © 2016 Nice Agency. All rights reserved.
//

import Log

import Quick
import Nimble

class LogTests: QuickSpec {
    
    override func spec() {
        describe("Log") {
            it("logs the input with location identification and time") {
                let date = Date()
                Log.logLevel = .none
                Log.logDomain = Domain.common
                
                let output = Log.log(.none, "an error occurred")
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("23"))
                expect(output).to(contain("\(Calendar.current.component(.hour, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.minute, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.second, from: date))"))
            }
        }
        
        describe("Log") {
            it("logs error but not warning or debug input with location identification and time") {
                let date = Date()
                Log.logLevel = .error
                Log.logDomain = Domain.common
                
                let output = Log.log(.error, "an error occurred")
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("40"))
                expect(output).to(contain("\(Calendar.current.component(.hour, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.minute, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.second, from: date))"))
                
                let noWarning = Log.log(.warn, "empty")
                
                expect(noWarning).to(beEmpty())
                
                let noDebug = Log.log(.debug, "empty")
                
                expect(noDebug).to(beEmpty())
            }
        }
        
        describe("Log") {
            it("logs error and warning but not debug input with location identification and time") {
                let date = Date()
                Log.logLevel = .warn
                Log.logDomain = Domain.common
                
                let output = Log.log(.error, "an error occurred")
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("65"))
                expect(output).to(contain("\(Calendar.current.component(.hour, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.minute, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.second, from: date))"))
                
                let warningOutput = Log.log(.warn, "a warning occurred")
                
                expect(warningOutput).to(contain("a warning occurred"))
                expect(warningOutput).to(contain("LogTests"))
                expect(warningOutput).to(contain("74"))
                expect(warningOutput).to(contain("\(Calendar.current.component(.hour, from: date))"))
                expect(warningOutput).to(contain("\(Calendar.current.component(.minute, from: date))"))
                expect(warningOutput).to(contain("\(Calendar.current.component(.second, from: date))"))
                
                let noDebug = Log.log(.debug, "empty")
                
                expect(noDebug).to(beEmpty())
            }
        }
        
        describe("Log") {
            it("logs error, warning and debug input with location identification and time") {
                let date = Date()
                Log.logLevel = .debug
                Log.logDomain = Domain.common
                
                let output = Log.log(.error, "an error occurred")
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("95"))
                expect(output).to(contain("\(Calendar.current.component(.hour, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.minute, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.second, from: date))"))
                
                let warningOutput = Log.log(.warn, "a warning occurred")
                
                expect(warningOutput).to(contain("a warning occurred"))
                expect(warningOutput).to(contain("LogTests"))
                expect(warningOutput).to(contain("104"))
                expect(warningOutput).to(contain("\(Calendar.current.component(.hour, from: date))"))
                expect(warningOutput).to(contain("\(Calendar.current.component(.minute, from: date))"))
                expect(warningOutput).to(contain("\(Calendar.current.component(.second, from: date))"))
                
                let debugOutput = Log.log(.warn, "a debug occurred")
                
                expect(debugOutput).to(contain("a debug occurred"))
                expect(debugOutput).to(contain("LogTests"))
                expect(debugOutput).to(contain("113"))
                expect(debugOutput).to(contain("\(Calendar.current.component(.hour, from: date))"))
                expect(debugOutput).to(contain("\(Calendar.current.component(.minute, from: date))"))
                expect(debugOutput).to(contain("\(Calendar.current.component(.second, from: date))"))
            }
        }
        
        describe("Log") {
            it("logs all for common domain input with location identification and time") {
                let date = Date()
                Log.logLevel = .none
                Log.logDomain = Domain.common
                
                let output = Log.log(.none, "an error occurred", domain: Domain.common)
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("130"))
                expect(output).to(contain("\(Calendar.current.component(.hour, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.minute, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.second, from: date))"))
                
                let networkOutput = Log.log(.none, "a network error occurred", domain: Domain.network)
                
                expect(networkOutput).to(contain("a network error occurred"))
                expect(networkOutput).to(contain("LogTests"))
                expect(networkOutput).to(contain("139"))
                expect(networkOutput).to(contain("\(Calendar.current.component(.hour, from: date))"))
                expect(networkOutput).to(contain("\(Calendar.current.component(.minute, from: date))"))
                expect(networkOutput).to(contain("\(Calendar.current.component(.second, from: date))"))
            }
        }
        
        describe("Log") {
            it("logs only specific domain input with location identification and time") {
                let date = Date()
                Log.logLevel = .none
                Log.logDomain = Domain.network
                
                let output = Log.log(.none, "a network error occurred", domain: Domain.network)
                
                expect(output).to(contain("a network error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("156"))
                expect(output).to(contain("\(Calendar.current.component(.hour, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.minute, from: date))"))
                expect(output).to(contain("\(Calendar.current.component(.second, from: date))"))
                
                let noOutput = Log.log(.none, "a network error occurred", domain: Domain.common)
                
                expect(noOutput).to(beEmpty())
                
                let noOtherOutput = Log.log(.none, "a network error occurred", domain: Domain.model)
                
                expect(noOtherOutput).to(beEmpty())
            }
        }
        
        describe("Log") {
            it("logs input with location identification and custom time") {
                Log.logLevel = .none
                Log.logDomain = Domain.common
                
                let originalFormatter = Log.formatter
                
                Log.formatter = DateFormatter()
                Log.formatter.dateFormat = "'custom text'"
                
                let output = Log.log(.none, "an error occurred")
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("185"))
                expect(output).to(contain("custom text"))
                expect(output).toNot(match("/d:"))
                
                Log.formatter = originalFormatter
            }
        }
        
        describe("Log") {
            it("logs the calling function name") {
                Log.logLevel = .none
                Log.logDomain = Domain.common
                
                let output = Log.log(.none, "an error occurred")
                
                expect(output).to(contain("spec()"))
            }
        }
        
    }
}
