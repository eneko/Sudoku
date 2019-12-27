//
//  IndexTests.swift
//  MatrixTests
//
//  Created by Eneko Alonso on 12/26/19.
//

//
//  SudokuSolutionTests.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import XCTest
import Matrix
import SudokuKit

final class IndexTests: XCTestCase {

    func testColumnIndexes() {
        let matrix = Matrix(values: PuzzleExamples.easy, columns: 9)
        XCTAssertEqual(matrix.columnIndex(forCell: 0), 0)
        XCTAssertEqual(matrix.columnIndex(forCell: 37), 1)
        XCTAssertEqual(matrix.columnIndex(forCell: 11), 2)
        XCTAssertEqual(matrix.columnIndex(forCell: 67), 4)
        XCTAssertEqual(matrix.columnIndex(forCell: 5), 5)
        XCTAssertEqual(matrix.columnIndex(forCell: 24), 6)
        XCTAssertEqual(matrix.columnIndex(forCell: 43), 7)
        XCTAssertEqual(matrix.columnIndex(forCell: 80), 8)
    }

    func testRowIndexes() {
        let matrix = Matrix(values: PuzzleExamples.easy, columns: 9)
        XCTAssertEqual(matrix.rowIndex(forCell: 12), 1)
        XCTAssertEqual(matrix.rowIndex(forCell: 52), 5)
        XCTAssertEqual(matrix.rowIndex(forCell: 77), 8)
        XCTAssertEqual(matrix.rowIndex(forCell: 38), 4)
        XCTAssertEqual(matrix.rowIndex(forCell: 4),  0)
        XCTAssertEqual(matrix.rowIndex(forCell: 8),  0)
        XCTAssertEqual(matrix.rowIndex(forCell: 66), 7)
        XCTAssertEqual(matrix.rowIndex(forCell: 35), 3)
        XCTAssertEqual(matrix.rowIndex(forCell: 9),  1)
    }

}
