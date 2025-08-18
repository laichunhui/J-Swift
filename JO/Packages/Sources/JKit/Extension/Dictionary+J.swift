//
//  File.swift
//  Packages
//
//  Created by jee on 2025/8/18.
//

import Foundation

extension Dictionary {
    /// SwifterSwift: Check if key exists in dictionary.
    ///
    ///        let dict: [String: Any] = ["testKey": "testValue", "testArrayKey": [1, 2, 3, 4, 5]]
    ///        dict.has(key: "testKey") -> true
    ///        dict.has(key: "anotherKey") -> false
    ///
    /// - Parameter key: key to search for.
    /// - Returns: true if key exists in dictionary.
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    /// SwifterSwift: Remove all keys contained in the keys parameter from the dictionary.
    ///
    ///        var dict : [String: String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    ///        dict.removeAll(keys: ["key1", "key2"])
    ///        dict.keys.contains("key3") -> true
    ///        dict.keys.contains("key1") -> false
    ///        dict.keys.contains("key2") -> false
    ///
    /// - Parameter keys: keys to be removed.
    mutating func removeAll<S: Sequence>(keys: S) where S.Element == Key {
        keys.forEach { removeValue(forKey: $0) }
    }
    
    public  func stringValue(isPrettyPrinted: Bool = false) -> String? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONString")
            return nil
        }
        let data : Data? = try? JSONSerialization.data(withJSONObject: self, options: isPrettyPrinted ? .prettyPrinted : [])
        if let data = data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    public func dataValue() -> Data? {
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONData")
            return nil
        }
        let data : Data? = try? JSONSerialization.data(withJSONObject: self, options: [])
        return data
    }
    
    public func model<T:Codable>(type: T.Type) -> T? {
        guard let data = dataValue() else {
            return nil
        }
        let jsonDe = JSONDecoder()
        do {
            let results = try jsonDe.decode(T.self, from: data)
            return results
        } catch {
            print(error)
        }
        return nil
    }
}
