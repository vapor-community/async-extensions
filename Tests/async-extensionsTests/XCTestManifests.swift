import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(async_extensionsTests.allTests),
    ]
}
#endif