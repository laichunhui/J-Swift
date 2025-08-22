//
//  View+Decoration.swift
//  TGChat
//
//  Created by tg2024 on 2024/8/2.
//

import Foundation
import SwiftUI
import JKit

public struct DecorationView: ViewModifier {
    private var backgroundColor: Color
    private var height: CGFloat
    private var cornerRadius: CGFloat
    
    init(backgroundColor: Color, height: CGFloat, cornerRadius: CGFloat) {
        self.backgroundColor = backgroundColor
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            backgroundColor
            content
        }
        .frame(height: height)
        .cornerRadius(cornerRadius)
    }
}

public extension View {
    func decoration(backgroundColor: Color, height: CGFloat, cornerRadius: CGFloat = 8) -> some View {
        modifier(DecorationView(backgroundColor: backgroundColor, height: height, cornerRadius: cornerRadius))
    }
}

public struct BackgroundClearView: UIViewRepresentable {
    public init() {}
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
}

public struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    public init(style: UIBlurEffect.Style) {
        self.style = style
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
