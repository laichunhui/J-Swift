//
//  File.swift
//
//
//  Created by Summer wu on 2024/4/9.
//

import Foundation
import SwiftUI
import UIKit

public struct TGFontStyle {
    public let size: TGFontSize
    public let weight: TGFontWeight
    public let color: Color
    public let isNumber: Bool

    public init(
        size: TGFontSize, weight: TGFontWeight, color: Color,
        isNumber: Bool = false
    ) {
        self.size = size
        self.weight = weight
        self.color = color
        self.isNumber = isNumber
    }
}

public enum TGFontWeight: Int {
    case regular
    case medium
    case bold
}

public enum TGFontSize: CGFloat {
    case big = 28
    case h1 = 24
    /// 字号：20
    case h2 = 20
    /// 字号：18
    case h3 = 18
    /// 字号：16
    case h4 = 16
    /// 字号：14
    case t1 = 14
    /// 字号：12
    case t2 = 12
    /// 字号：11
    case t3 = 11
    /// 字号：10
    case t4 = 10
    /// 字号：9
    case t5 = 9
}

public enum TGFont {
    case num(size: TGFontSize, weight: TGFontWeight = .regular)
    case normal(size: TGFontSize, weight: TGFontWeight)

    public static func register() {
        let fontURLs = [
            Bundle.module.url(
                forResource: "Gilroy-Regular", withExtension: "otf"),
            Bundle.module.url(
                forResource: "Gilroy-Medium", withExtension: "ttf"),
        ].compactMap { $0 }

        for url in fontURLs {
            guard let provider = CGDataProvider(url: url as CFURL),
                let font = CGFont(provider)
            else { continue }
            CTFontManagerRegisterGraphicsFont(font, nil)
        }

        //        let bundle = R.font.dinBold.bundle
        //        if let cfURL = bundle.url(forResource: R.font.gilroyRegular.name, withExtension: "otf") {
        //            CTFontManagerRegisterFontsForURL(cfURL as CFURL, .process, nil)
        //        }
        //        if let cfURL = bundle.url(forResource: R.font.gilroyMedium.name, withExtension: "ttf") {
        //            CTFontManagerRegisterFontsForURL(cfURL as CFURL, .process, nil)
        //        }
        //        if let cfURL = bundle.url(forResource: R.font.dinBold.name, withExtension: "otf") {
        //            CTFontManagerRegisterFontsForURL(cfURL as CFURL, .process, nil)
        //        }
    }

    public var font: SwiftUI.Font {

        switch self {
        case let .normal(size, weight):
            switch weight {
            case .regular:
                return Font(R.font.gilroyRegular(size: size.rawValue)!)
            case .medium:
                return Font(R.font.gilroyMedium(size: size.rawValue)!)
            case .bold:
                return Font(R.font.gilroyBold(size: size.rawValue)!)
            }
        case let .num(size, weight):
            switch weight {
            case .regular:
                return Font(R.font.dinRegular(size: size.rawValue)!)
            case .medium:
                return Font(R.font.dinMedium(size: size.rawValue)!)
            case .bold:
                return Font(R.font.dinBold(size: size.rawValue)!)
            }
        }
    }

    public var uiFont: UIFont {
        switch self {
        case let .normal(size, weight):
            switch weight {
            case .regular:
                return R.font.gilroyRegular(size: size.rawValue)!
            case .medium:
                return R.font.gilroyMedium(size: size.rawValue)!
            case .bold:
                return R.font.gilroyBold(size: size.rawValue)!
            }
        case let .num(size, weight):
            switch weight {
            case .regular:
                return R.font.dinRegular(size: size.rawValue)!
            case .medium:
                return R.font.dinMedium(size: size.rawValue)!
            case .bold:
                return R.font.dinBold(size: size.rawValue)!
            }
        }
    }
}

extension Text {
    ///H1 字体: PingFang SC 字号：32 字重: SemiBold
    public static func h1(_ content: String, fontWeight: TGFontWeight = .bold)
        -> Text
    {
        return Text(content).font(
            TGFont.normal(size: .h1, weight: fontWeight).font)
    }

    ///H2 字体: PingFang SC 字号：24 字重: SemiBold
    public static func h2(_ content: String, fontWeight: TGFontWeight = .bold)
        -> Text
    {
        return Text(content).font(
            TGFont.normal(size: .h2, weight: fontWeight).font)
    }

    ///H3 字体: PingFang SC 字号：20 字重: SemiBold
    public static func h3(_ content: String, fontWeight: TGFontWeight = .bold)
        -> Text
    {
        return Text(content).font(
            TGFont.normal(size: .h3, weight: fontWeight).font)
    }

    ///H4 字体: PingFang SC 字号：18 字重: SemiBold
    public static func h4(_ content: String, fontWeight: TGFontWeight = .bold)
        -> Text
    {
        return Text(content).font(
            TGFont.normal(size: .h4, weight: fontWeight).font)
    }

    ///T1 字体: PingFang SC 字号：15 字重: regular
    public static func t1(
        _ content: String, fontWeight: TGFontWeight = .regular
    ) -> Text {
        return Text(content).font(
            TGFont.normal(size: .t1, weight: fontWeight).font)
    }

    ///T2 字体: PingFang SC 字号：14 字重: regular
    public static func t2(
        _ content: String, fontWeight: TGFontWeight = .regular
    ) -> Text {
        return Text(content).font(
            TGFont.normal(size: .t2, weight: fontWeight).font)
    }

    ///T3 字体: PingFang SC 字号：12 字重: regular
    public static func t3(
        _ content: String, fontWeight: TGFontWeight = .regular
    ) -> Text {
        return Text(content).font(
            TGFont.normal(size: .t3, weight: fontWeight).font)
    }

    ///T4 字体: PingFang SC 字号：10 字重: regular
    public static func t4(
        _ content: String, fontWeight: TGFontWeight = .regular
    ) -> Text {
        return Text(content).font(
            TGFont.normal(size: .t4, weight: fontWeight).font)
    }

    ///T5 字体: PingFang SC 字号：9 字重: regular
    public static func t5(
        _ content: String, fontWeight: TGFontWeight = .regular
    ) -> Text {
        return Text(content).font(
            TGFont.normal(size: .t5, weight: fontWeight).font)
    }
}

// MARK: - StandardText
struct StandardText: ViewModifier {
    var size: TGFontSize
    var weight: TGFontWeight
    var color: Color
    var isNumber = false
    func body(content: Content) -> some View {
        content
            .foregroundColor(color)
            .font(
                isNumber
                    ? TGFont.num(size: size, weight: weight).font
                    : TGFont.normal(size: size, weight: weight).font
            )
            .lineSpacing(6)
    }
}

extension View {
    public func fontStyle(
        size: TGFontSize, weight: TGFontWeight = .medium,
        color: Color = Color(
            uiColor: UIColor.init(
                red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1)),
        isNumber: Bool = false
    ) -> some View {
        modifier(
            StandardText(
                size: size, weight: weight, color: color, isNumber: isNumber))
    }
}
