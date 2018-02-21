import XCTest
@testable import async_extensions

final class async_extensionsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(async_extensions().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
