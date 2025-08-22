//
//  File.swift
//  Packages
//
//  Created by work on 27/12/24.
//

import SwiftUI
import JResources
import JKit

public struct MarqueeText: View {
    @State private var animate = false
    var text: String = ""
    let fontStyle: TGFontStyle
    // 限制宽度
    let width: CGFloat
    public init(text: String, fontStyle: TGFontStyle, width: CGFloat = .infinity) {
        self.text = text
        self.fontStyle = fontStyle
        let textWidth = text.j.width(font: TGFont.normal(size: fontStyle.size, weight: fontStyle.weight).uiFont)
        self.width = min(textWidth, width)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let maxWidth = min(geometry.size.width, width)
            let textWidth = calculateTextWidth(for: text, font: TGFont.normal(size: fontStyle.size, weight: fontStyle.weight).uiFont)

            ZStack {
                if textWidth > maxWidth {
                    Marquee(targetVelocity: 50) {
                        Text(text)
                            .fontStyle(size: fontStyle.size, weight: fontStyle.weight, color: fontStyle.color)
                            .lineLimit(1)
                            .frame(alignment: .leading)
                    }
                } else {
                    Text(text)
                        .fontStyle(size: fontStyle.size, weight: fontStyle.weight, color: fontStyle.color)
                        .lineLimit(1)
                        .frame(width: textWidth, alignment: .leading)
                }
            }
        }
        .frame(maxWidth: width)
        .clipped()
    }

    private func calculateTextWidth(for text: String, font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size.width
    }
}

public struct Marquee<Content: View>: View {
    @ViewBuilder var content: Content
    @State private var containerWidth: CGFloat? = nil
    @State private var model: MarqueeModel
    private var targetVelocity: Double
    private var spacing: CGFloat
    
    public init(targetVelocity: Double, spacing: CGFloat = 10, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._model = .init(wrappedValue: MarqueeModel(targetVelocity: targetVelocity, spacing: spacing))
        self.targetVelocity = targetVelocity
        self.spacing = spacing
    }
    
    var extraContentInstances: Int {
        let contentPlusSpacing = ((model.contentWidth ?? 0) + model.spacing)
        guard contentPlusSpacing != 0 else { return 1 }
        return Int(((containerWidth ?? 0) / contentPlusSpacing).rounded(.up))
    }
    
    public var body: some View {
        TimelineView(.animation) { context in
            HStack(spacing: model.spacing) {
                HStack(spacing: model.spacing) {
                    content
                }
                .measureWidth { model.contentWidth = $0 }
                ForEach(Array(0..<extraContentInstances), id: \.self) { _ in
                    content
                }
            }
            .offset(x: model.offset)
            .fixedSize()
            .onChange(of: context.date) { newDate in
                DispatchQueue.main.async {
                    model.tick(at: newDate)
                    
                }
            }
        }
        .measureWidth { containerWidth = $0 }
        .gesture(dragGesture)
        .onAppear { model.previousTick = .now }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                model.dragChanged(value)
            }.onEnded { value in
                model.dragEnded(value)
            }
    }
    
    private func throttle(delay: Double, action: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            action()
        }
    }
}


struct MarqueeModel {
    var contentWidth: CGFloat? = nil
    var offset: CGFloat = 0
    var dragStartOffset: CGFloat? = nil
    var dragTranslation: CGFloat = 0
    var currentVelocity: CGFloat = 0
    
    var previousTick: Date = .now
    var targetVelocity: Double
    var spacing: CGFloat
    init(targetVelocity: Double, spacing: CGFloat) {
        self.targetVelocity = targetVelocity
        self.spacing = spacing
    }
    
    mutating func tick(at time: Date) {
        let delta = time.timeIntervalSince(previousTick)
        defer { previousTick = time }
        currentVelocity += (targetVelocity - currentVelocity) * delta * 3
        if let dragStartOffset {
            offset = dragStartOffset + dragTranslation
        } else {
            offset -= delta * currentVelocity
        }
        if let c = contentWidth {
            offset.formTruncatingRemainder(dividingBy: c + spacing)
            while offset > 0 {
                offset -= c + spacing
            }
            
        }
    }
    
    mutating func dragChanged(_ value: DragGesture.Value) {
        if dragStartOffset == nil {
            dragStartOffset = offset
        }
        dragTranslation = value.translation.width
    }
    
    mutating func dragEnded(_ value: DragGesture.Value) {
        offset = dragStartOffset! + value.translation.width
        dragStartOffset = nil
    }
    
}

public extension View {
    func measureWidth(_ onChange: @escaping (CGFloat) -> ()) -> some View {
        background {
            GeometryReader { proxy in
                let width = proxy.size.width
                Color.clear
                    .onAppear {
                        DispatchQueue.main.async {
                            onChange(width)
                        }
                    }.onChange(of: width) {
                        onChange($0)
                    }
            }
        }
    }
}
