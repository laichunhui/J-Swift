//
//  File.swift
//  
//
//  Created by JerryLai on 2023/8/3.
//

import SwiftUI

public struct FlippedUpsideDown: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .rotationEffect(.radians(Double.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
    }
}

public extension View {
    func flippedUpsideDown() -> some View {
        modifier(FlippedUpsideDown())
    }
}

public struct ViewMirror: ViewModifier {
    @Environment(\.layoutDirection) var direction
    public func body(content: Content) -> some View {
        content
            .scaleEffect(x: direction == .rightToLeft ? -1 : 1, y: 1)
    }
}

public extension View {
    func layoutMirror() -> some View {
        modifier(ViewMirror())
    }
}

public struct LayoutDirectionArrow: View {
    @Environment(\.layoutDirection) var direction
    let size: CGFloat
    let color: Color
    public init(size: CGFloat, color: Color) {
        self.size = size
        self.color = color
    }
    
    public var body: some View {
        direction == .rightToLeft ? Image(systemName: "chevron.left") : Image(systemName: "chevron.right")
    }
}
