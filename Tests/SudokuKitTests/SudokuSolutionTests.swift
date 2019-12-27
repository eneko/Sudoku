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
//        let solution = SudokuSolution(puzzle: SudokuPuzzle(cells: Sudokus.easy))
        XCTAssertEqual(SudokuSolution.allowedValues.count, 9)
    }

    func testColumnIndexes() throws {
        let solution = try SudokuSolution(puzzle: SudokuPuzzle(integers: PuzzleExamples.easy))
        XCTAssertEqual(solution.column(for: 0), 0)
        XCTAssertEqual(solution.column(for: 37), 1)
        XCTAssertEqual(solution.column(for: 11), 2)
        XCTAssertEqual(solution.column(for: 67), 4)
        XCTAssertEqual(solution.column(for: 5), 5)
        XCTAssertEqual(solution.column(for: 24), 6)
        XCTAssertEqual(solution.column(for: 43), 7)
        XCTAssertEqual(solution.column(for: 80), 8)
    }

    func testRowIndexes() throws {
        let solution = try SudokuSolution(puzzle: SudokuPuzzle(integers: PuzzleExamples.easy))
        XCTAssertEqual(solution.row(for: 12), 1)
        XCTAssertEqual(solution.row(for: 52), 5)
        XCTAssertEqual(solution.row(for: 77), 8)
        XCTAssertEqual(solution.row(for: 38), 4)
        XCTAssertEqual(solution.row(for: 4),  0)
        XCTAssertEqual(solution.row(for: 8),  0)
        XCTAssertEqual(solution.row(for: 66), 7)
        XCTAssertEqual(solution.row(for: 35), 3)
        XCTAssertEqual(solution.row(for: 9),  1)
    }

    func testSquareIndexes() throws {
        let solution = try SudokuSolution(puzzle: SudokuPuzzle(integers: PuzzleExamples.easy))
        XCTAssertEqual(solution.square(for: 50).squareColumn, 1)
        XCTAssertEqual(solution.square(for: 50).squareRow, 1)
        XCTAssertEqual(solution.square(for: 0).squareColumn, 0)
        XCTAssertEqual(solution.square(for: 0).squareRow, 0)
        XCTAssertEqual(solution.square(for: 80).squareColumn, 2)
        XCTAssertEqual(solution.square(for: 80).squareRow, 2)
        XCTAssertEqual(solution.square(for: 31).squareColumn, 1)
        XCTAssertEqual(solution.square(for: 31).squareRow, 1)
        XCTAssertEqual(solution.square(for: 25).squareColumn, 2)
        XCTAssertEqual(solution.square(for: 25).squareRow, 0)
    }
}
