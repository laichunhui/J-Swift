import Foundation

public struct JExtension<Base> {
    public var base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol IJExtension {
    associatedtype AnyType
    var j: AnyType { get set }
}

extension IJExtension {
    public var j: JExtension<Self> {
        get { JExtension(self) }
        set {
            self = newValue.base
        }
    }
}
