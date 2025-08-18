//
//  FloatEx.swift
//  WGKit
//
//  Created by test on 2022/1/17.
//

import Foundation

public extension Float {
    /// 准确的小数尾截取 - 没有进位
    func decimalString(_ base: Self = 4) -> String {
        let tempCount: Self = pow(10, base)
        let temp = self*tempCount
        
        let target = Self(Int(temp))
        let stepone = target/tempCount
        if stepone.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", stepone)
        } else {
            return "\(stepone)"
        }
    }
}

public extension Double {
    /// 显示格式化: 小数点后面显示 位数: 0 - places
    func formatted(toPlaces places: Int) -> String {
        let factor = pow(10.0, Double(places))
        let roundedValue = (self * factor).rounded() / factor

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = places
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: roundedValue)) ?? "\(self)"
    }
}

public extension Double {
    func formatTimestamp(format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
}
