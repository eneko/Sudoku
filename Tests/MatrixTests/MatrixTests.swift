//
//  MatrixTests.swift
//  MatrixTests
//
//  Created by Eneko Alonso on 12/26/19.
//

import XCTest
import Matrix

class MatrixTests: XCTestCase {

    func testRows() {
        XCTAssertEqual(Matrix(values: 1...5, columns: 5).rows, 1)
        XCTAssertEqual(Matrix(values: 1...10, columns: 5).rows, 2)
    }

    func testSubMatrix() {
        let matrix = Matrix(values: 1...16, columns: 4)
        XCTAssertEqual(matrix.subMatrix(columns: 2, rows: 2, fromCell: 0).cells, [1, 2, 5, 6])
        XCTAssertEqual(matrix.subMatrix(columns: 2, rows: 2, fromCell: 2).cells, [3, 4, 7, 8])
        XCTAssertEqual(matrix.subMatrix(columns: 2, rows: 2, fromCell: 8).cells, [9, 10, 13, 14])
        XCTAssertEqual(matrix.subMatrix(columns: 2, rows: 2, fromCell: 10).cells, [11, 12, 15, 16])
    }
}
