//
//  File.swift
//  
//
//  Created by 李智聪 on 2023/7/11.
//

import Foundation
import SwiftUI
import JKit

//public struct HighlightedText: View {
//    var text: String
//    var keyword: String
//    var keyColor: Color
//    var font: WGFont
//    var keyFont: WGFont
//    var textColor: Color
//    
//    public init(text: String, keyword: String,font: WGFont, textColor: Color, keyColor: Color = TGColor.main, keyFont: WGFont) {
//        self.text = text
//        self.keyword = keyword
//        self.keyColor = keyColor
//        self.font = font
//        self.keyFont = keyFont
//        self.textColor = textColor
//    }
//    public var body: some View {
//        if #available(iOS 15.0, macOS 12.0, *) {
//          return Text(AttributedString(NSMutableAttributedString.init(text: text, rangeKey: keyword, keyColor: UIColor(keyColor), keyFont: keyFont.langFont)))
//                .foregroundColor(textColor)
//                .font(Font(font.langFont))
//        } else {
//            let textParts = text.components(separatedBy: keyword)
//            var combinedText = Text("")
//            for index in textParts.indices {
//                combinedText = combinedText + Text(textParts.wgElement(at: index) ?? "")
//                    .font(Font(font.langFont))
//                    .foregroundColor(textColor)
//                if index != textParts.count - 1 {
//                    combinedText = combinedText + Text(keyword)
//                        .font(Font(keyFont.langFont))
//                        .foregroundColor(keyColor)
//                }
//            }
//            return combinedText
//        }
//    }
//}

