//
//  File.swift
//  Packages
//
//  Created by jee on 2025/8/18.
//

import Foundation
import CocoaLumberjackSwift

public enum Logger {
    public static func configure() {
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
        DDLog.add(DDOSLogger.sharedInstance, with: .debug)
    }
    
    public static func debug(_ message: @autoclosure () -> Any) {
        DDLogDebug("[D] \(message())")
    }
    
    public static func info(_ message: @autoclosure () -> Any) {
        DDLogInfo("[I] \(message())")
    }
    
    public static func warn(_ message: @autoclosure () -> Any) {
        DDLogWarn("[W] \(message())")
    }

    public static func error(_ message: @autoclosure () -> Any) {
        DDLogError("[E] \(message())")
    }
}
