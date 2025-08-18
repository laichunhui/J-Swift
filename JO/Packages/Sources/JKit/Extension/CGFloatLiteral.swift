//
//  CGFloatLiteral.swift
//  Avatalk
//
//  Created by laichunhui on 2021/2/4.
//  Copyright © 2021 maoshi. All rights reserved.
//

import UIKit

// MARK: - CGFloat 快速转换
public extension IntegerLiteralType {
    var f: CGFloat {
    return CGFloat(self)
  }
}

public extension FloatLiteralType {
   var f: CGFloat {
    return CGFloat(self)
  }
}

public extension FloatLiteralType {
   var i: Int {
    return Int(self)
  }
}
