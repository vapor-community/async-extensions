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
        let t = Future(true)
        let f = Future(false)

        XCTAssertEqual(try t.true(or: CustomError()).blockingAwait(), true)
        XCTAssertThrowsError(try f.true(or: CustomError()).blockingAwait())
    }

    func testFalse() throws {
        let t = Future(true)
        let f = Future(false)

        XCTAssertThrowsError(try t.false(or: CustomError()).blockingAwait())
        XCTAssertEqual(try f.false(or: CustomError()).blockingAwait(), true)
    }

    func testEqual() throws {
        let f1 = Future(34)
        let f2 = Future("string")

        XCTAssertEqual(try f1.equal(to: 34).blockingAwait(), true)
        XCTAssertEqual(try f1.equal(to: 30).blockingAwait(), false)

        XCTAssertNoThrow(try f1.equal(to: 34, or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try f1.equal(to: 30, or: CustomError()).blockingAwait())

        XCTAssertEqual(try f2.equal(to: "string").blockingAwait(), true)
        XCTAssertEqual(try f2.equal(to: "not-equal").blockingAwait(), false)

        XCTAssertNoThrow(try f2.equal(to: "string", or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try f2.equal(to: "not-equal", or: CustomError()).blockingAwait())
    }

    func testNotEqual() throws {
        let f1 = Future(34)
        let f2 = Future("string")

        XCTAssertEqual(try f1.notEqual(to: 34).blockingAwait(), false)
        XCTAssertEqual(try f1.notEqual(to: 30).blockingAwait(), true)

        XCTAssertThrowsError(try f1.notEqual(to: 34, or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try f1.notEqual(to: 30, or: CustomError()).blockingAwait())

        XCTAssertEqual(try f2.notEqual(to: "string").blockingAwait(), false)
        XCTAssertEqual(try f2.notEqual(to: "not-equal").blockingAwait(), true)

        XCTAssertThrowsError(try f2.notEqual(to: "string", or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try f2.notEqual(to: "not-equal", or: CustomError()).blockingAwait())
    }

    func testGreater() throws {
        let f1 = Future(34)

        XCTAssertEqual(try f1.greater(than: 10).blockingAwait(), true)
        XCTAssertEqual(try f1.greater(than: 34).blockingAwait(), false)
        XCTAssertEqual(try f1.greater(than: 50).blockingAwait(), false)

        XCTAssertNoThrow(try f1.greater(than: 10, or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try f1.greater(than: 34, or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try f1.greater(than: 50, or: CustomError()).blockingAwait())
    }

    func testGreaterOrEqual() throws {
        let f1 = Future(34)

        XCTAssertEqual(try f1.greaterOrEqual(to: 10).blockingAwait(), true)
        XCTAssertEqual(try f1.greaterOrEqual(to: 34).blockingAwait(), true)
        XCTAssertEqual(try f1.greaterOrEqual(to: 50).blockingAwait(), false)

        XCTAssertNoThrow(try f1.greaterOrEqual(to: 10, or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try f1.greaterOrEqual(to: 34, or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try f1.greaterOrEqual(to: 50, or: CustomError()).blockingAwait())
    }

    func testLess() throws {
        let f1 = Future(34)

        XCTAssertEqual(try f1.less(than: 10).blockingAwait(), false)
        XCTAssertEqual(try f1.less(than: 34).blockingAwait(), false)
        XCTAssertEqual(try f1.less(than: 50).blockingAwait(), true)

        XCTAssertThrowsError(try f1.less(than: 10, or: CustomError()).blockingAwait())
        XCTAssertThrowsError(try f1.less(than: 34, or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try f1.less(than: 50, or: CustomError()).blockingAwait())
    }

    func testLessOrEqual() throws {
        let f1 = Future(34)

        XCTAssertEqual(try f1.lessOrEqual(to: 10).blockingAwait(), false)
        XCTAssertEqual(try f1.lessOrEqual(to: 34).blockingAwait(), true)
        XCTAssertEqual(try f1.lessOrEqual(to: 50).blockingAwait(), true)

        XCTAssertThrowsError(try f1.lessOrEqual(to: 10, or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try f1.lessOrEqual(to: 34, or: CustomError()).blockingAwait())
        XCTAssertNoThrow(try f1.lessOrEqual(to: 50, or: CustomError()).blockingAwait())
    }

    static let allTests = [
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