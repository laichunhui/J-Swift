//
//  ViewConstants.swift
//  WGKit
//
//  Created by laichunhui on 2021/5/25.
//

import UIKit

/// 屏幕宽度
@MainActor public var kScreenWidth: CGFloat {
    UIScreen.main.bounds.width
}

/// 屏幕高度
@MainActor public var kScreenHeight: CGFloat {
    UIScreen.main.bounds.height
}

/// 屏幕缩放比例
@MainActor public var kScreenScale: CGFloat {
    UIScreen.main.scale
}

/// 屏幕大小
@MainActor public var kScreenSize: CGSize {
    UIScreen.main.bounds.size
}

/// 根据屏幕宽度计算缩放值
@MainActor public func WS(_ v: CGFloat) -> CGFloat {
    let scale = kScreenWidth / 375
    return v * scale
}
