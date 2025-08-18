//
//  File.swift
//  Packages
//
//  Created by jee on 2025/8/18.
//

import Foundation

extension String: IJExtension {}

public extension JExtension where Base == String {
    /// 去掉首尾空格 包括换行 \n
    mutating func removeHeadAndTailSpace() {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        base = base.trimmingCharacters(in: whitespace)
    }
    
    mutating func removeSpaceAndLineBreak() {
        removeHeadAndTailSpace()
        var temp = ""
        var spaceNum = 0
        for char in base {
            if char == "\n" {
                if spaceNum < 1 {
                    temp.append(char)
                }
                spaceNum += 1
            } else {
                temp.append(char)
                spaceNum = 0
            }
        }
        base = temp
    }
    
    // 1 -> 01
    func padLeft(_ toLength: Int, withPad character: Character = "0") -> String {
        let countDiff = toLength - base.count
        if countDiff > 0 {
            return String(repeating: String(character), count: countDiff) + base
        } else {
            return base
        }
    }
    
    /// 用utf编码时的长度
    var utf8Length: Int {
        let encoding = String.Encoding.utf8
        if let gbkData = base.data(using: encoding) {
            let gbkBytes = [UInt8](gbkData)
            return gbkBytes.count
        }
        return base.count
    }
}

