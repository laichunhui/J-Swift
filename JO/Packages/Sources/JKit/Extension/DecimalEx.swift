//
//  DecimalEx.swift
//  TGUI
//
//  Created by tg2024 on 2024/7/3.
//

import Foundation

extension Decimal {
    /// "$0.00"
    public func currencyStyle(style: NumberFormatter.Style = .currency, LocaleId: String = "en_US") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = style
        numberFormatter.locale = Locale(identifier: LocaleId)
        return numberFormatter.string(from: NSDecimalNumber(decimal: self)) ?? ""
    }
}
