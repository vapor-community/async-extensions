//
//  LinuxMain.swift
//  AsyncExtensions
//
//  Created by Gustavo Perdomo on 02/20/18.
//  Copyright © 2018 Vapor Community. All rights reserved.
//

import XCTest

import AsyncExtensionsTests

var tests = [XCTestCaseEntry]()
tests += FutureExtensionsTests.allTests()
XCTMain(tests)