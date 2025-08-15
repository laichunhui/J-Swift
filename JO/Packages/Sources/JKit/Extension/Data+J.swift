//
//  File.swift
//  Packages
//
//  Created by jee on 2025/8/15.
//

import Foundation

public enum DataConversionError: Error {
    case insufficientData
    case invalidEncoding
}

extension Data {
    public init<T>(from value: T) {
        self = withUnsafePointer(to: value) { (ptr: UnsafePointer<T>) -> Data in
            Data(buffer: UnsafeBufferPointer(start: ptr, count: 1))
        }
    }

}

extension Data: IJExtension {}

extension JExtension where Base == Data {

    public var hex: String {
        base.reduce("") {
            $0 + String(format: "%02x", $1)
        }
    }

    public var hexString: String {
        "0x" + hex
    }

    public var reversedHex: String {
        Data(base.reversed()).j.hex
    }

    public var bytes: [UInt8] {
        Array(base)
    }

    public func to<T: FixedWidthInteger>(type: T.Type) throws -> T {
        guard base.count >= MemoryLayout<T>.size else {
            throw DataConversionError.insufficientData
        }
        return base.withUnsafeBytes { ptr in
            guard let baseAddress = ptr.baseAddress else {
                fatalError("Failed to get base address")
            }
            return baseAddress.assumingMemoryBound(to: T.self).pointee
        }
    }

    public func to(type: String.Type, encoding: String.Encoding = .ascii) throws -> String {
        guard
            let string = String(bytes: base, encoding: encoding)?.replacingOccurrences(
                of: "\0", with: "")
        else {
            throw DataConversionError.invalidEncoding
        }
        return string
    }

    //    func to(type: VarInt.Type) -> VarInt {
    //        let value: UInt64
    //        let length = base[0..<1].tg.to(type: UInt8.self)
    //        switch length {
    //        case 0...252:
    //            value = UInt64(length)
    //        case 0xfd:
    //            value = UInt64(base[1...2].tg.to(type: UInt16.self))
    //        case 0xfe:
    //            value = UInt64(base[1...4].tg.to(type: UInt32.self))
    //        case 0xff:
    //            fallthrough
    //        default:
    //            value = base[1...8].tg.to(type: UInt64.self)
    //        }
    //        return VarInt(value)
    //    }

}
