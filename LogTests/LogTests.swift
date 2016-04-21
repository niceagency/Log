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
                let date = NSDate()
                Log.logLevel = .None
                Log.logDomain = Domain.Common
                
                let output = Log.log(.None, "an error occurred")
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("23"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Hour, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Minute, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Second, fromDate: date))"))
            }
        }
        
        describe("Log") {
            it("logs error but not warning or debug input with location identification and time") {
                let date = NSDate()
                Log.logLevel = .Error
                Log.logDomain = Domain.Common
                
                let output = Log.log(.Error, "an error occurred")
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("40"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Hour, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Minute, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Second, fromDate: date))"))
                
                let noWarning = Log.log(.Warn, "empty")
                
                expect(noWarning).to(beEmpty())
                
                let noDebug = Log.log(.Debug, "empty")
                
                expect(noDebug).to(beEmpty())
            }
        }
        
        describe("Log") {
            it("logs error and warning but not debug input with location identification and time") {
                let date = NSDate()
                Log.logLevel = .Warn
                Log.logDomain = Domain.Common
                
                let output = Log.log(.Error, "an error occurred")
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("65"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Hour, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Minute, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Second, fromDate: date))"))
                
                let warningOutput = Log.log(.Warn, "a warning occurred")
                
                expect(warningOutput).to(contain("a warning occurred"))
                expect(warningOutput).to(contain("LogTests"))
                expect(warningOutput).to(contain("74"))
                expect(warningOutput).to(contain("\(NSCalendar.currentCalendar().component(.Hour, fromDate: date))"))
                expect(warningOutput).to(contain("\(NSCalendar.currentCalendar().component(.Minute, fromDate: date))"))
                expect(warningOutput).to(contain("\(NSCalendar.currentCalendar().component(.Second, fromDate: date))"))
                
                let noDebug = Log.log(.Debug, "empty")
                
                expect(noDebug).to(beEmpty())
            }
        }
        
        describe("Log") {
            it("logs error, warning and debug input with location identification and time") {
                let date = NSDate()
                Log.logLevel = .Debug
                Log.logDomain = Domain.Common
                
                let output = Log.log(.Error, "an error occurred")
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("95"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Hour, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Minute, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Second, fromDate: date))"))
                
                let warningOutput = Log.log(.Warn, "a warning occurred")
                
                expect(warningOutput).to(contain("a warning occurred"))
                expect(warningOutput).to(contain("LogTests"))
                expect(warningOutput).to(contain("104"))
                expect(warningOutput).to(contain("\(NSCalendar.currentCalendar().component(.Hour, fromDate: date))"))
                expect(warningOutput).to(contain("\(NSCalendar.currentCalendar().component(.Minute, fromDate: date))"))
                expect(warningOutput).to(contain("\(NSCalendar.currentCalendar().component(.Second, fromDate: date))"))
                
                let debugOutput = Log.log(.Warn, "a debug occurred")
                
                expect(debugOutput).to(contain("a debug occurred"))
                expect(debugOutput).to(contain("LogTests"))
                expect(debugOutput).to(contain("113"))
                expect(debugOutput).to(contain("\(NSCalendar.currentCalendar().component(.Hour, fromDate: date))"))
                expect(debugOutput).to(contain("\(NSCalendar.currentCalendar().component(.Minute, fromDate: date))"))
                expect(debugOutput).to(contain("\(NSCalendar.currentCalendar().component(.Second, fromDate: date))"))
            }
        }
        
        describe("Log") {
            it("logs all for common domain input with location identification and time") {
                let date = NSDate()
                Log.logLevel = .None
                Log.logDomain = Domain.Common
                
                let output = Log.log(.None, "an error occurred", domain: Domain.Common)
                
                expect(output).to(contain("an error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("130"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Hour, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Minute, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Second, fromDate: date))"))
                
                let networkOutput = Log.log(.None, "a network error occurred", domain: Domain.Network)
                
                expect(networkOutput).to(contain("a network error occurred"))
                expect(networkOutput).to(contain("LogTests"))
                expect(networkOutput).to(contain("139"))
                expect(networkOutput).to(contain("\(NSCalendar.currentCalendar().component(.Hour, fromDate: date))"))
                expect(networkOutput).to(contain("\(NSCalendar.currentCalendar().component(.Minute, fromDate: date))"))
                expect(networkOutput).to(contain("\(NSCalendar.currentCalendar().component(.Second, fromDate: date))"))
            }
        }
        
        describe("Log") {
            it("logs only specific domain input with location identification and time") {
                let date = NSDate()
                Log.logLevel = .None
                Log.logDomain = Domain.Network
                
                let output = Log.log(.None, "a network error occurred", domain: Domain.Network)
                
                expect(output).to(contain("a network error occurred"))
                expect(output).to(contain("LogTests"))
                expect(output).to(contain("156"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Hour, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Minute, fromDate: date))"))
                expect(output).to(contain("\(NSCalendar.currentCalendar().component(.Second, fromDate: date))"))
                
                let noOutput = Log.log(.None, "a network error occurred", domain: Domain.Common)
                
                expect(noOutput).to(beEmpty())
                
                let noOtherOutput = Log.log(.None, "a network error occurred", domain: Domain.Model)
                
                expect(noOtherOutput).to(beEmpty())
            }
        }
        
        describe("Log") {
            it("logs input with location identification and custom time") {
                Log.logLevel = .None
                Log.logDomain = Domain.Common
                
                let originalFormatter = Log.formatter
                
                Log.formatter = NSDateFormatter()
                Log.formatter.dateFormat = "'custom text'"
                
                let output = Log.log(.None, "an error occurred")
                
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
                Log.logLevel = .None
                Log.logDomain = Domain.Common
                
                let output = Log.log(.None, "an error occurred")
                
                expect(output).to(contain("spec()"))
            }
        }
        
    }
}
