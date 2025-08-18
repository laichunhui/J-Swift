//
//  CharacterEx.swift
//  WGKit
//
//  Created by laichunhui on 2022/6/30.
//

import Foundation

public extension Character {
    /// 简单的emoji是一个标量，以emoji的形式呈现给用户
    var isSimpleEmoji: Bool {
        guard let firstProperties = unicodeScalars.first?.properties else {
            return false
        }
        if #available(iOS 10.2, *) {
            return firstProperties.isEmojiPresentation ||
            firstProperties.generalCategory == .otherSymbol
        } else { // 10.2 以下暂时无法做出准确判断
            return firstProperties.generalCategory == .otherSymbol
        }
    }
    
    /// 检查标量是否将合并到emoji中
    var isCombinedIntoEmoji: Bool {
        return unicodeScalars.count > 1 &&
        unicodeScalars.contains { $0.properties.isJoinControl || $0.properties.isVariationSelector }
    }
    
    /// 是否为emoji表情
    /// - Note: http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
    var isEmoji: Bool {
        return isSimpleEmoji || isCombinedIntoEmoji
    }
}
