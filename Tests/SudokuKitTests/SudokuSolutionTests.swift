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

    func testColumns() throws {
        let solution = try SudokuSolution(puzzle: SudokuPuzzle(integers: PuzzleExamples.easy))
        XCTAssertEqual(solution.columns.count, 9)
        solution.columns.forEach {
            XCTAssertEqual($0.count, 9)
        }
    }

    func testRows() throws {
        let solution = try SudokuSolution(puzzle: SudokuPuzzle(integers: PuzzleExamples.easy))
        XCTAssertEqual(solution.rows.count, 9)
        solution.rows.forEach {
            XCTAssertEqual($0.count, 9)
        }
    }

    func testSquares() throws {
        let solution = try SudokuSolution(puzzle: SudokuPuzzle(integers: PuzzleExamples.easy))
        XCTAssertEqual(solution.squares.count, 9)
        solution.squares.forEach {
            XCTAssertEqual($0.count, 9)
        }
    }

    func testSquareIndexesForCell() throws {
        let solution = try SudokuSolution(puzzle: SudokuPuzzle(integers: PuzzleExamples.easy))
        XCTAssertEqual(solution.squareIndex(forCell:  0), 0)
        XCTAssertEqual(solution.squareIndex(forCell: 25), 2)
        XCTAssertEqual(solution.squareIndex(forCell: 31), 4)
        XCTAssertEqual(solution.squareIndex(forCell: 50), 4)
        XCTAssertEqual(solution.squareIndex(forCell: 80), 8)
    }

    func testCellIndexesForSquare() throws {
        let solution = try SudokuSolution(puzzle: SudokuPuzzle(integers: PuzzleExamples.easy))
        XCTAssertEqual(solution.cellIndex(forSquare: 0),  0)
        XCTAssertEqual(solution.cellIndex(forSquare: 1),  3)
        XCTAssertEqual(solution.cellIndex(forSquare: 2),  6)
        XCTAssertEqual(solution.cellIndex(forSquare: 3), 27)
        XCTAssertEqual(solution.cellIndex(forSquare: 4), 30)
        XCTAssertEqual(solution.cellIndex(forSquare: 5), 33)
        XCTAssertEqual(solution.cellIndex(forSquare: 6), 54)
        XCTAssertEqual(solution.cellIndex(forSquare: 7), 57)
        XCTAssertEqual(solution.cellIndex(forSquare: 8), 60)
    }
}
