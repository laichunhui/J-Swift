//
//  File.swift
//  Packages
//
//  Created by jee on 2025/8/21.
//

import CoreText
import UIKit

public extension JExtension where Base == String {
    func width(font: UIFont) -> CGFloat {
        let attrString = NSAttributedString(string: base, attributes: [.font: font])
        let line = CTLineCreateWithAttributedString(attrString)
        return CGFloat(CTLineGetTypographicBounds(line, nil, nil, nil))
    }
}
