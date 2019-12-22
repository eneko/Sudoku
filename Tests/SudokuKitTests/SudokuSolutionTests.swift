//
//  SudokuSolutionTests.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import XCTest
import SudokuKit

final class SudokuSolutionTests: XCTestCase {

    func testValues() {
//        let solution = SudokuSolution(puzzle: SudokuPuzzle(cells: Sudokus.easy))
        XCTAssertEqual(SudokuSolution.validValues.count, 9)
    }
}
