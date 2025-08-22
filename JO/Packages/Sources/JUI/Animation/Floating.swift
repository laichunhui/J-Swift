//
//  File.swift
//  
//
//  Created by JerryLai on 2023/11/29.
//

import SwiftUI

public extension View {
    func floating(_ floating: Binding<Bool>,
               duration: CGFloat = 0.8,
               offsetRange: CGFloat = 10,
               onCompletion: (() -> Void)? = nil) -> some View {
        Floating(floating: floating,
              duration: duration,
              offsetRange: offsetRange) {
            self
        } onCompletion: {
            onCompletion?()
        }
    }
}

struct Floating<Content: View>: View {
    /// Set to true in order to animate
    @Binding var floating: Bool
    /// Duration in seconds
    var duration = 0.8
    /// Range in pixels to go back and forth
    var offsetRange = 10.0

    @ViewBuilder let content: Content
    var onCompletion: (() -> Void)?

    @State private var xOffset = 0.0
    @State private var yOffset = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var up = true
    let offset: CGFloat
    init(floating: Binding<Bool>, duration: Double = 0.8, offsetRange: Double = 10.0, @ViewBuilder content: () -> (Content), onCompletion: (() -> Void)? = nil) {
        self._floating = floating
        self.duration = duration
        self.offsetRange = offsetRange
        self.content = content()
        self.onCompletion = onCompletion
        self.offset = offsetRange * 2 * 0.1 / duration
        
    }
    
    var body: some View {
        content
            .offset(x: xOffset, y: yOffset)
            .onReceive(timer) { _ in
                if floating {
                    if up {
                        yOffset += offset
                        if yOffset >= offsetRange {
                            up = false
                        }
                    } else {
                        yOffset -= offset
                        if yOffset <= -offsetRange {
                            up = true
                        }
                    }
                }
            }
    }
}
