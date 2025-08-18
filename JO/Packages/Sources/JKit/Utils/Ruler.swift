//
//  Ruler.swift
//  Ruler
// reference linking:  https://github.com/nixzhu/Ruler

/** 使用示例
/** 示例1  UIView 在不同屏幕宽度的 iPhone 中显示不同的宽度值并显示不同的背景色
 
 320 - 宽度为20, 背景色为红色
 375 - 宽度为30, 背景色为灰色
 414 - 宽度为40, 背景色为蓝色
 */
let view = UIView()
view.frame.size.width = SYRuler.iPhoneHorizontal(20, 30, 40).value
view.backgroundColor = SYRuler.iPhoneHorizontal(UIColor.red, UIColor.gray, UIColor.blue).value

/** 示例2  UILabel 在不同屏幕高度的 iPhone 中显示不同的内容
 
 480 - "我是老老款"
 568 - "我是老款"
 667 - "我流行"
 736 - "我大"
 812 - "我更大"
 */
let label = UILabel()
label.text = SYRuler.iPhoneVertical("我是老老款", "我是老款", "我流行", "我大", "我更大").value
 
iphone 11, 12: (390.0, 844.0)
12pro max: screen_size:(428.0, 926.0)
*/
import UIKit

private enum ScreenModel {
    case inch4
    case bigger
    case biggerPlus
    case x
    case xMax
    
    public enum PadModel {
        case normal
        case pro
    }
    case iPad(PadModel)
}

@MainActor
private let screenModel: ScreenModel = {
    let screen = UIScreen.main
    let height = max(screen.bounds.width, screen.bounds.height)
    switch height {
    case 568:
        return .inch4
    case 667:
        return .bigger
    case 736, 1920:
        return .biggerPlus
    case 812, 844:
        return .x
    case 896, 926:
        return .xMax
    case 1024:
        return .iPad(.normal)
    case 1112, 1366:
        return .iPad(.pro)
    default:
        print("Warning: Can NOT detect screenModel! bounds: \(screen.bounds) nativeScale: \(screen.nativeScale)")
        return .x // Default
    }
}()

@MainActor 
public enum Ruler<T> {
    /**
    - (320):
    - (375, 390): iphone8、iphone13mini
    - (414, 428): iphone11
     */
    case iPhoneHorizontal(T, T, T)
    /**
     - (568):
     - (667): 678
     - (736): 678plus
     - (812, 844): X、XS、12mini、13mini
     - (896, 926): XR、11、12ProMax、13ProMax
     */
    case iPhoneVertical(T, T, T, T, T)
    case iPad(T, T)
    case universalHorizontal(T, T, T, T, T)
    case universalVertical(T, T, T, T, T, T, T)
    
    public var value: T {
        switch self {
        case let .iPhoneHorizontal(classic, bigger, biggerPlus):
            switch screenModel {
            case .inch4:
                return classic
            case .bigger:
                return bigger
            case .biggerPlus:
                return biggerPlus
            case .x:
                return bigger
            case .xMax:
                return biggerPlus
            default:
                return biggerPlus
            }
        case let .iPhoneVertical(inch4, bigger, biggerPlus, x, xMax):
            switch screenModel {
            case .inch4:
                return inch4
            case .bigger:
                return bigger
            case .biggerPlus:
                return biggerPlus
            case .x:
                return x
            case .xMax:
                return xMax
            default:
                return biggerPlus
            }
        case let .iPad(normal, pro):
            switch screenModel {
            case .iPad(let model):
                switch model {
                case .normal:
                    return normal
                case .pro:
                    return pro
                }
            default:
                return normal
            }
        case let .universalHorizontal(classic, bigger, biggerPlus, iPadNormal, iPadPro):
            switch screenModel {
            case .inch4:
                return classic
            case .bigger:
                return bigger
            case .biggerPlus:
                return biggerPlus
            case .x:
                return bigger
            case .xMax:
                return biggerPlus
            case .iPad(let model):
                switch model {
                case .normal:
                    return iPadNormal
                case .pro:
                    return iPadPro
                }
            }
        case let .universalVertical(inch4, bigger, biggerPlus, x, xMax, iPadNormal, iPadPro):
            switch screenModel {
            case .inch4:
                return inch4
            case .bigger:
                return bigger
            case .biggerPlus:
                return biggerPlus
            case .x:
                return x
            case .xMax:
                return xMax
            case .iPad(let model):
                switch model {
                case .normal:
                    return iPadNormal
                case .pro:
                    return iPadPro
                }
            }
        }
    }
}
