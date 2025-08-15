//
//  WGBlock.swift
//  WGKit
//
//  Created by laichunhui on 2021/8/10.
//

import Foundation

public typealias JVoidBlock = () -> Void
public typealias JGenericBlock<T> = (T) -> Void

public enum JResult {
    case success
    case failure(JApiError)
}

public struct JApiError: Error {
    public var code: Int
    public var des: String
    
    public init(code: Int, des: String) {
        self.code = code
        self.des = des
    }
}

public struct TGVoidBlockWrapper: Equatable {
    var id : String {
        return UUID().uuidString
    }
    public static func == (lhs: TGVoidBlockWrapper, rhs: TGVoidBlockWrapper) -> Bool {
        lhs.id == rhs.id
    }
    
    var block: JVoidBlock?
    public  init(block: JVoidBlock?) {
        self.block = block
    }
    public func call() {
        block?()
    }
}

public struct JGenericBlockWrapper<T>: Equatable {
    var id : String {
        return UUID().uuidString
    }
    public static func == (lhs: JGenericBlockWrapper, rhs: JGenericBlockWrapper) -> Bool {
        lhs.id == rhs.id
    }
    
    public var block: JGenericBlock<T>?
    
    public init(block: JGenericBlock<T>? ) {
        self.block = block
    }
    public func call(value: T) {
        block?(value)
    }
    
}
