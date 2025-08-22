//
//  File.swift
//  Packages
//
//  Created by work on 8/11/24.
//

import SwiftUI
import JResources
import JKit

public struct JButton: View {
    public let title: String
    public let fontSize: TGFontSize
    public let fontWeight: TGFontWeight
    public let titleColor: Color
    public let bgColor: Color
    public let cornerRadius: CGFloat
    public let height: CGFloat
    public let tap: JVoidBlock?
    
    public init(title: String, fontSize: TGFontSize = .h4, fontWeight: TGFontWeight = .medium, titleColor: Color = .white, bgColor: Color, cornerRadius: CGFloat = 25, height: CGFloat = 50, tap: JVoidBlock?) {
        self.title = title
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.titleColor = titleColor
        self.bgColor = bgColor
        self.cornerRadius = cornerRadius
        self.height = height
        self.tap = tap
    }
    
    public var body: some View {
        Button {
            tap?()
        }  label: {
            HStack {
                Text(title)
                    .fontStyle(size: .h4, weight: fontWeight, color: titleColor)
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}

public struct ThrottledButton: View {
    let action: () -> Void
    let title: String
    let interval: TimeInterval
    
    @State private var isButtonDisabled = false
    
    public init(title: String, interval: TimeInterval, action: @escaping () -> Void) {
        self.action = action
        self.title = title
        self.interval = interval
    }

    public var body: some View {
        Button(action: handleClick) {
            Text(title)
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisabled ? Color.gray : Color.blue)
                .cornerRadius(8)
        }
        .disabled(isButtonDisabled)
    }

    private func handleClick() {
        action()
        isButtonDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            isButtonDisabled = false
        }
    }
}
