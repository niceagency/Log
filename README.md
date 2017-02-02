# Log
___

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/niceagency/Log) [![Carthage compatible](https://img.shields.io/badge/twitter-%40niceagency-blue.svg)](https://twitter.com/niceagency)

Log is a general purpose logging solution, offering levels and filtering, and the ability to collect the log for alternate storage / forwarding to other services.

## Features
___

* Set a current level and domain restriction to filter the log output
* Includes a timestamp, file location, function name and line number in the log output

## Install
___

Install with Carthage or simply by dragging the Log.swift (and BasicLog.swift) file(s). Can also be installed with CocoaPods, but Log isn't listed in the official podspec, so you'll need to direct reference the repo.
You can optionally use the BasicLog file or use it as an example of a domain and level system.

## Usage
___

It's recommended that you start by using the provided `BasicLogDomain` and `BasicLogLevel`. This is best done by extending `BasicLogDomain` to specify your logging domains and the level for each dmain:

```
extension BasicLogDomain {
    static let commonSpec: Log<BasicLogDomain, BasicLogLevel>.LoggerSpec = (domain: .common, level: .debug, logger: nil)
    static let networkSpec: Log<BasicLogDomain, BasicLogLevel>.LoggerSpec = (domain: .network, level: .debug, logger: nil)
    static let modelSpec: Log<BasicLogDomain, BasicLogLevel>.LoggerSpec = (domain: .model, level: .debug, logger: nil)

    static let logStore = Log<BasicLogDomain, BasicLogLevel>(specs: [commonSpec, networkSpec, modelSpec])

    public func log<T>(_ level: BasicLogLevel, _ object: T, filename: String = #file, line: Int = #line, funcname: String = #function) {
        let logger = BasicLogDomain.logStore.log(self)

        logger.log(level, object, filename: filename, line: line, funcname: funcname)
    }
}
```

It's also useful to shorten the naming to make the call site simple and to make any custom domain configuration you setup in the future easy to use:

`typealias DLog = BasicLogDomain`

It's then as simple as:

`DLog.common.log(.debug, "Hello world")`

## Contributions
___

If you wish to contribute to Log please fork the repository and send a pull request or raise an issue within GitHub.

## License
___

Log is released under the MIT license. See LICENSE for details.
