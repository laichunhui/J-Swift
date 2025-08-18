//
//  File.swift
//  
//
//  Created by JerryLai on 2023/7/12.
//

import SwiftUI

public extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.j.utf8Length > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}

