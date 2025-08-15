import XCTest
@testable import JKit

final class JTests: XCTestCase {

    // MARK: - Array Extension Tests

    func testElementAt() {
        let array = [1, 2, 3, 4, 5]

        // 正常索引测试
        XCTAssertEqual(array.j.element(at: 0), 1)
        XCTAssertEqual(array.j.element(at: 4), 5)

        // 边界测试
        XCTAssertNil(array.j.element(at: -1))
        XCTAssertNil(array.j.element(at: 5))

        // 空数组测试
        let emptyArray: [Int] = []
        XCTAssertNil(emptyArray.j.element(at: 0))
    }

    func testSample() {
        let array = [1, 2, 3, 4, 5]

        // 测试正常采样（允许重复）
        if let sample = array.j.sample(size: 3) {
            XCTAssertEqual(sample.count, 3)
            sample.forEach { element in
                XCTAssertTrue(array.contains(element))
            }
        } else {
            XCTFail("Sample should not be nil")
        }

        // 测试不允许重复的采样
        if let uniqueSample = array.j.sample(size: 3, noRepeat: true) {
            XCTAssertEqual(uniqueSample.count, 3)
            XCTAssertEqual(Set(uniqueSample).count, 3)  // 确保没有重复
            uniqueSample.forEach { element in
                XCTAssertTrue(array.contains(element))
            }
        } else {
            XCTFail("Unique sample should not be nil")
        }

        // 测试空数组
        let emptyArray: [Int] = []
        XCTAssertNil(emptyArray.j.sample(size: 1))

        // 测试请求大小超过数组大小（不允许重复）
        if let oversizedSample = array.j.sample(size: 10, noRepeat: true) {
            XCTAssertEqual(oversizedSample.count, 5)
            XCTAssertEqual(Set(oversizedSample).count, 5)
        } else {
            XCTFail("Oversized sample should not be nil")
        }
    }

    func testFilterDuplicates() {
        // 测试基本数字数组
        let numbers = [1, 2, 2, 3, 3, 3, 4]
        let uniqueNumbers = numbers.j.filterDuplicates { $0 }
        XCTAssertEqual(uniqueNumbers, [1, 2, 3, 4])

        // 测试自定义对象
        struct TestObject {
            let id: Int
            let name: String
        }

        let objects = [
            TestObject(id: 1, name: "A"),
            TestObject(id: 1, name: "B"),
            TestObject(id: 2, name: "C"),
        ]

        let uniqueObjects = objects.j.filterDuplicates { $0.id }
        XCTAssertEqual(uniqueObjects.count, 2)
        XCTAssertEqual(uniqueObjects.map { $0.id }, [1, 2])
    }

    func testReplace() {
        var array = [1, 2, 3, 4, 5]

        // 测试正常替换
        array.j.replace(10, at: 2)
        XCTAssertEqual(array, [1, 2, 10, 4, 5])

        // 测试边界情况
        array.j.replace(20, at: -1)  // 不应该改变数组
        XCTAssertEqual(array, [1, 2, 10, 4, 5])

        array.j.replace(20, at: 5)  // 不应该改变数组
        XCTAssertEqual(array, [1, 2, 10, 4, 5])
    }

    func testRemove() {
        var array = [1, 2, 3, 4, 5]

        // 测试正常删除
        array.j.remove(at: 2)
        XCTAssertEqual(array, [1, 2, 4, 5])

        // 测试边界情况
        array.j.remove(at: -1)  // 不应该改变数组
        XCTAssertEqual(array, [1, 2, 4, 5])

        array.j.remove(at: 4)  // 不应该改变数组
        XCTAssertEqual(array, [1, 2, 4, 5])
    }

    func testSwap() {
        var array = [1, 2, 3, 4, 5]

        // 测试正常交换
        array.j.swap(from: 1, to: 3)
        XCTAssertEqual(array, [1, 4, 3, 2, 5])

        // 测试相同位置交换
        array.j.swap(from: 2, to: 2)
        XCTAssertEqual(array, [1, 4, 3, 2, 5])

        // 测试边界情况
        array.j.swap(from: -1, to: 1)  // 不应该改变数组
        XCTAssertEqual(array, [1, 4, 3, 2, 5])

        array.j.swap(from: 1, to: 5)  // 不应该改变数组
        XCTAssertEqual(array, [1, 4, 3, 2, 5])
    }
}
