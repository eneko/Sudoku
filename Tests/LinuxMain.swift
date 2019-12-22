import XCTest

import SudokuKitTests
import SudokuTests

var tests = [XCTestCaseEntry]()
tests += SudokuKitTests.__allTests()
tests += SudokuTests.__allTests()

XCTMain(tests)
