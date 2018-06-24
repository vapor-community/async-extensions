//
//  FutureExtensionsTests.swift
//  AsyncExtensions
//
//  Created by Gustavo Perdomo on 02/20/18.
//  Copyright © 2018 Vapor Community. All rights reserved.
//

import Async
import XCTest
@testable import AsyncExtensions

// MARK: - Methods

final class FutureExtensionsTests: XCTestCase {
    func testTrue() throws {
        let futTrue = Future(true)
        let futFalse = Future(false)

        XCTAssertEqual(try futTrue.true(or: CustomError()).blockingAwait(), true)
        XCTAssertThrowsError(try futFalse.true(or: CustomError()).blockingAwait())
    }

    func testFalse() throws {
        let futTrue = Future(true)
        let futFalse = Future(false)

        XCTAssertThrowsError(try futTrue.false(or: CustomError()).blockingAwait())
        XCTAssertEqual(try futFalse.false(or: CustomError()).blockingAwait(), true)
    }

    func testEqual() throws {
        let fut1 = Future(34)
        let fut2 = Future("string")

        XCTAssertEqual(try fut1.equal(to: 34).blockingAwait(), true)
        XCTAssertEqual(try fut1.equal(to: 30).blockingAwait(), false)

        XCTAssertNoThrow(try fut1.equal(to: 34, or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try fut1.equal(to: 30, or: CustomError()).blockingAwait())

        XCTAssertEqual(try fut2.equal(to: "string").blockingAwait(), true)
        XCTAssertEqual(try fut2.equal(to: "not-equal").blockingAwait(), false)

        XCTAssertNoThrow(try fut2.equal(to: "string", or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try fut2.equal(to: "not-equal", or: CustomError()).blockingAwait())
    }

    func testNotEqual() throws {
        let fut1 = Future(34)
        let fut2 = Future("string")

        XCTAssertEqual(try fut1.notEqual(to: 34).blockingAwait(), false)
        XCTAssertEqual(try fut1.notEqual(to: 30).blockingAwait(), true)

        XCTAssertThrowsError(try fut1.notEqual(to: 34, or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try fut1.notEqual(to: 30, or: CustomError()).blockingAwait())

        XCTAssertEqual(try fut2.notEqual(to: "string").blockingAwait(), false)
        XCTAssertEqual(try fut2.notEqual(to: "not-equal").blockingAwait(), true)

        XCTAssertThrowsError(try fut2.notEqual(to: "string", or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try fut2.notEqual(to: "not-equal", or: CustomError()).blockingAwait())
    }

    func testGreater() throws {
        let fut1 = Future(34)

        XCTAssertEqual(try fut1.greater(than: 10).blockingAwait(), true)
        XCTAssertEqual(try fut1.greater(than: 34).blockingAwait(), false)
        XCTAssertEqual(try fut1.greater(than: 50).blockingAwait(), false)

        XCTAssertNoThrow(try fut1.greater(than: 10, or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try fut1.greater(than: 34, or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try fut1.greater(than: 50, or: CustomError()).blockingAwait())
    }

    func testGreaterOrEqual() throws {
        let fut1 = Future(34)

        XCTAssertEqual(try fut1.greaterOrEqual(to: 10).blockingAwait(), true)
        XCTAssertEqual(try fut1.greaterOrEqual(to: 34).blockingAwait(), true)
        XCTAssertEqual(try fut1.greaterOrEqual(to: 50).blockingAwait(), false)

        XCTAssertNoThrow(try fut1.greaterOrEqual(to: 10, or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try fut1.greaterOrEqual(to: 34, or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try fut1.greaterOrEqual(to: 50, or: CustomError()).blockingAwait())
    }

    func testLess() throws {
        let fut1 = Future(34)

        XCTAssertEqual(try fut1.less(than: 10).blockingAwait(), false)
        XCTAssertEqual(try fut1.less(than: 34).blockingAwait(), false)
        XCTAssertEqual(try fut1.less(than: 50).blockingAwait(), true)

        XCTAssertThrowsError(try fut1.less(than: 10, or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try fut1.less(than: 34, or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try fut1.less(than: 50, or: CustomError()).blockingAwait())
    }

    func testLessOrEqual() throws {
        let fut1 = Future(34)

        XCTAssertEqual(try fut1.lessOrEqual(to: 10).blockingAwait(), false)
        XCTAssertEqual(try fut1.lessOrEqual(to: 34).blockingAwait(), true)
        XCTAssertEqual(try fut1.lessOrEqual(to: 50).blockingAwait(), true)

        XCTAssertThrowsError(try fut1.lessOrEqual(to: 10, or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try fut1.lessOrEqual(to: 34, or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try fut1.lessOrEqual(to: 50, or: CustomError()).blockingAwait())
    }

    func testLinuxTestSuiteIncludesAllTests() throws {
        #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
        let thisClass = type(of: self)
        let linuxCount = thisClass.allTests.count
        let darwinCount = Int(thisClass.defaultTestSuite.testCaseCount)

        XCTAssertEqual(linuxCount, darwinCount, "\(darwinCount - linuxCount) tests are missing from allTests")
        #endif
    }

    static let allTests = [
        ("testLinuxTestSuiteIncludesAllTests", testLinuxTestSuiteIncludesAllTests),
        ("testTrue", testTrue),
        ("testFalse", testFalse),
        ("testEqual", testEqual),
        ("testNotEqual", testNotEqual),
        ("testGreater", testGreater),
        ("testGreaterOrEqual", testGreaterOrEqual),
        ("testLess", testLess),
        ("testLessOrEqual", testLessOrEqual)
    ]
}

struct CustomError: Error {}
