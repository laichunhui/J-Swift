//
//  File.swift
//  Packages
//
//  Created by work on 26/11/24.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder func `if`<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        transform: (Self) -> TrueContent,
        else elseTransform: ((Self) -> FalseContent)? = nil
    ) -> some View {
        if condition {
            transform(self)
        } else {
            if let elseTransform {
                elseTransform(self)
            } else {
                self
            }
        }
    }
    
    @ViewBuilder func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
