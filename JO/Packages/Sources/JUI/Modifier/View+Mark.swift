//
//  File.swift
//  
//
//  Created by JerryLai on 2023/7/28.
//

import SwiftUI

public struct BottomSepline: ViewModifier {
    public var color: Color
    var paddingLeft: CGFloat
    var paddingRight: CGFloat
    public init(color: Color = Color.gray, paddingLeft: CGFloat = 0, paddingRight: CGFloat = 0) {
        self.color = color
        self.paddingLeft = paddingLeft
        self.paddingRight = paddingRight
    }
    
    public func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(color)
                .padding(.leading, paddingLeft)
                .padding(.trailing, paddingRight)
        }
    }
}

public extension View {
    func sepBottomLine(color: Color = Color.gray, paddingLeft: CGFloat = 0, paddingRight: CGFloat = 0) -> some View {
        modifier(BottomSepline(color: color, paddingLeft: paddingLeft, paddingRight: paddingRight))
    }
}
