//
//  SudokuSolutionTests.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import XCTest
@testable import SudokuKit

final class SudokuSolutionTests: XCTestCase {

    func testValues() {
        XCTAssertEqual(SudokuSolution.allowedValues.count, 9)
    }

    func testSquareIndexes() throws {
        let solution = try SudokuSolution(puzzle: SudokuPuzzle(integers: PuzzleExamples.easy))
        XCTAssertEqual(solution.squareIndices(forCell: 50).squareColumn, 1)
        XCTAssertEqual(solution.squareIndices(forCell: 50).squareRow, 1)
        XCTAssertEqual(solution.squareIndices(forCell: 0).squareColumn, 0)
        XCTAssertEqual(solution.squareIndices(forCell: 0).squareRow, 0)
        XCTAssertEqual(solution.squareIndices(forCell: 80).squareColumn, 2)
        XCTAssertEqual(solution.squareIndices(forCell: 80).squareRow, 2)
        XCTAssertEqual(solution.squareIndices(forCell: 31).squareColumn, 1)
        XCTAssertEqual(solution.squareIndices(forCell: 31).squareRow, 1)
        XCTAssertEqual(solution.squareIndices(forCell: 25).squareColumn, 2)
        XCTAssertEqual(solution.squareIndices(forCell: 25).squareRow, 0)
    }
}
