//
//  File.swift
//  Packages
//
//  Created by jee on 2025/8/18.
//

import Foundation

extension Date: IJExtension {}

public extension JExtension where Base == Date {
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = base.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }

    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = base.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    var timeIntStamp: Int64 {
        let timeInterval: TimeInterval = base.timeIntervalSince1970
        let timeStamp = Int64(timeInterval)
        return timeStamp
    }
    
    /// 毫秒级
    var timeIntMilliStamp: Int64 {
        let timeInterval: TimeInterval = base.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return millisecond
    }
    
    func timeString() -> String {
        let calendar = NSCalendar.current
        let units: Set<Calendar.Component> = [.day, .month, .day]
        let nowCmps = calendar.dateComponents(units, from: Date())
        let myCmps = calendar.dateComponents(units, from: base)
        let dateFmt = DateFormatter()
        
        if nowCmps.year != myCmps.year {
            dateFmt.dateFormat = "yyyy/MM/dd"
        } else {
            if nowCmps.day == myCmps.day {
                dateFmt.dateFormat = "HH:mm"
            } else if ((nowCmps.day ?? 0) - (myCmps.day ?? 0)) == 1 {
                return "Yestoday"
            } else {
                dateFmt.dateFormat = "MM/dd HH:mm";
            }
        }
        return dateFmt.string(from: base)
    }
    
    /**
     *  是否为今天
     */
    func isToday() -> Bool{
        let calendar = Calendar.current
        let unit: Set<Calendar.Component> = [.day,.month,.year]
        let nowComps = calendar.dateComponents(unit, from: Date())
        let selfCmps = calendar.dateComponents(unit, from: base)
        
        return (selfCmps.year == nowComps.year) &&
        (selfCmps.month == nowComps.month) &&
        (selfCmps.day == nowComps.day)
    }
    
    /// 相差天数
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: base, to: toDate)
        return components.day ?? 0
    }
    
    func year() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: base)
    }
    
    func format(string: String = "yyyy/MM/dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = string
        return dateFormatter.string(from: base)
    }
}
