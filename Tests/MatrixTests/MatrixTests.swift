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
        XCTAssertEqual(Matrix(values: 1...4, columns: 5).rows, 1)
        XCTAssertEqual(Matrix(values: 1...5, columns: 5).rows, 1)
        XCTAssertEqual(Matrix(values: 1...6, columns: 5).rows, 2)
        XCTAssertEqual(Matrix(values: 1...7, columns: 5).rows, 2)
        XCTAssertEqual(Matrix(values: 1...8, columns: 5).rows, 2)
        XCTAssertEqual(Matrix(values: 1...9, columns: 5).rows, 2)
        XCTAssertEqual(Matrix(values: 1...10, columns: 5).rows, 2)
        XCTAssertEqual(Matrix(values: 1...11, columns: 5).rows, 3)
    }

}
