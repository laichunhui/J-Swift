//
//  ArrayEx.swift
//  Avatalk
//

import UIKit

extension Array: IJExtension {}
 
extension JExtension where Base: RandomAccessCollection {
    public func element(at index: Int) -> Base.Element? {
        if base.count > index && index >= 0 {
            return base[base.index(base.startIndex, offsetBy: index)]
        }
        return nil
    }

    /// 从数组中从返回指定个数的元素
    ///
    /// - parameters:
    ///   - size: 希望返回的元素个数
    ///   - noRepeat: 返回的元素是否不可以重复（默认为false，可以重复）
    public func sample(size: Int, noRepeat: Bool = false) -> [Base.Element]? {
        //如果数组为空，则返回nil
        guard !base.isEmpty else { return nil }

        var sampleElements: [Base.Element] = []

        //返回的元素可以重复的情况
        if !noRepeat {
            for _ in 0..<size {
                if let e = base.randomElement() {
                    sampleElements.append(e)
                }
            }
        }
        //返回的元素不可以重复的情况
        else {
            //先复制一个新数组
            var copy = base.map { $0 }
            for _ in 0..<size {
                //当元素不能重复时，最多只能返回原数组个数的元素
                if copy.isEmpty { break }
                let randomIndex = Int(arc4random_uniform(UInt32(copy.count)))
                let element = copy[randomIndex]
                sampleElements.append(element)
                //每取出一个元素则将其从复制出来的新数组中移除
                copy.remove(at: randomIndex)
            }
        }

        return sampleElements
    }

    /// 去重
    public func filterDuplicates<E: Equatable>(_ filter: (Base.Element) -> E) -> [Base.Element] {
        var result = [Base.Element]()
        for value in base {
            let key = filter(value)
            if !result.map({ filter($0) }).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}

extension JExtension where Base: RangeReplaceableCollection {
    public mutating func replace(_ e: Base.Element, at index: Int) {
        guard index >= 0 && index < base.count else {
            print("out of range when replace")
            return
        }
        let i = base.index(base.startIndex, offsetBy: index)
        base.replaceSubrange(i...i, with: [e])
    }

    public mutating func remove(at index: Int) {
        guard index >= 0 && index < base.count else {
            print("out of range when remove")
            return
        }
        let i = base.index(base.startIndex, offsetBy: index)
        base.remove(at: i)
    }
}

extension JExtension where Base: MutableCollection {
    public mutating func swap(from intIndex: Int, to otherIntIndex: Int) {
        guard intIndex != otherIntIndex else { return }
        guard intIndex >= 0 && intIndex < base.count else { return }
        guard otherIntIndex >= 0 && otherIntIndex < base.count else { return }

        let i1 = base.index(base.startIndex, offsetBy: intIndex)
        let i2 = base.index(base.startIndex, offsetBy: otherIntIndex)
        base.swapAt(i1, i2)
    }
}
