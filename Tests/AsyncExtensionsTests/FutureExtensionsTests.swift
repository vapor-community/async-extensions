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
    let worker: Worker = EmbeddedEventLoop()
    
    func testTrue() throws {
        let futTrue = Future.map(on: worker) { true }
        let futFalse = Future.map(on: worker) { false }

        XCTAssertEqual(try futTrue.true(or: CustomError()).wait(), true)
        XCTAssertThrowsError(try futFalse.true(or: CustomError()).wait())
    }

    func testFalse() throws {
        let futTrue = Future.map(on: worker) { true }
        let futFalse = Future.map(on: worker) { false }

        XCTAssertThrowsError(try futTrue.false(or: CustomError()).wait())
        XCTAssertEqual(try futFalse.false(or: CustomError()).wait(), true)
    }

    func testEqual() throws {
        let fut1 = Future.map(on: worker) { 34 }
        let fut2 = Future.map(on: worker) { "string" }

        XCTAssertEqual(try fut1.equal(to: 34).wait(), true)
        XCTAssertEqual(try fut1.equal(to: 30).wait(), false)

        XCTAssertNoThrow(try fut1.equal(to: 34, or: CustomError()).wait())
        XCTAssertThrowsError(try fut1.equal(to: 30, or: CustomError()).wait())

        XCTAssertEqual(try fut2.equal(to: "string").wait(), true)
        XCTAssertEqual(try fut2.equal(to: "not-equal").wait(), false)

        XCTAssertNoThrow(try fut2.equal(to: "string", or: CustomError()).wait())
        XCTAssertThrowsError(try fut2.equal(to: "not-equal", or: CustomError()).wait())
    }

    func testNotEqual() throws {
        let fut1 = Future.map(on: worker) { 34 }
        let fut2 = Future.map(on: worker) { "string" }

        XCTAssertEqual(try fut1.notEqual(to: 34).wait(), false)
        XCTAssertEqual(try fut1.notEqual(to: 30).wait(), true)

        XCTAssertThrowsError(try fut1.notEqual(to: 34, or: CustomError()).wait())
        XCTAssertNoThrow(try fut1.notEqual(to: 30, or: CustomError()).wait())

        XCTAssertEqual(try fut2.notEqual(to: "string").wait(), false)
        XCTAssertEqual(try fut2.notEqual(to: "not-equal").wait(), true)

        XCTAssertThrowsError(try fut2.notEqual(to: "string", or: CustomError()).wait())
        XCTAssertNoThrow(try fut2.notEqual(to: "not-equal", or: CustomError()).wait())
    }

    func testGreater() throws {
        let fut1 = Future.map(on: worker) { 34 }

        XCTAssertEqual(try fut1.greater(than: 10).wait(), true)
        XCTAssertEqual(try fut1.greater(than: 34).wait(), false)
        XCTAssertEqual(try fut1.greater(than: 50).wait(), false)

        XCTAssertNoThrow(try fut1.greater(than: 10, or: CustomError()).wait())
        XCTAssertThrowsError(try fut1.greater(than: 34, or: CustomError()).wait())
        XCTAssertThrowsError(try fut1.greater(than: 50, or: CustomError()).wait())
    }

    func testGreaterOrEqual() throws {
        let fut1 = Future.map(on: worker) { 34 }

        XCTAssertEqual(try fut1.greaterOrEqual(to: 10).wait(), true)
        XCTAssertEqual(try fut1.greaterOrEqual(to: 34).wait(), true)
        XCTAssertEqual(try fut1.greaterOrEqual(to: 50).wait(), false)

        XCTAssertNoThrow(try fut1.greaterOrEqual(to: 10, or: CustomError()).wait())
        XCTAssertNoThrow(try fut1.greaterOrEqual(to: 34, or: CustomError()).wait())
        XCTAssertThrowsError(try fut1.greaterOrEqual(to: 50, or: CustomError()).wait())
    }

    func testLess() throws {
        let fut1 = Future.map(on: worker) { 34 }

        XCTAssertEqual(try fut1.less(than: 10).wait(), false)
        XCTAssertEqual(try fut1.less(than: 34).wait(), false)
        XCTAssertEqual(try fut1.less(than: 50).wait(), true)

        XCTAssertThrowsError(try fut1.less(than: 10, or: CustomError()).wait())
        XCTAssertThrowsError(try fut1.less(than: 34, or: CustomError()).wait())
        XCTAssertNoThrow(try fut1.less(than: 50, or: CustomError()).wait())
    }

    func testLessOrEqual() throws {
        let fut1 = Future.map(on: worker) { 34 }

        XCTAssertEqual(try fut1.lessOrEqual(to: 10).wait(), false)
        XCTAssertEqual(try fut1.lessOrEqual(to: 34).wait(), true)
        XCTAssertEqual(try fut1.lessOrEqual(to: 50).wait(), true)

        XCTAssertThrowsError(try fut1.lessOrEqual(to: 10, or: CustomError()).wait())
        XCTAssertNoThrow(try fut1.lessOrEqual(to: 34, or: CustomError()).wait())
        XCTAssertNoThrow(try fut1.lessOrEqual(to: 50, or: CustomError()).wait())
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
