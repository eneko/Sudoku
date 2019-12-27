import XCTest
import Matrix
import SudokuKit

final class RowTests: XCTestCase {
    //    0, 0, 0, 2, 0, 8, 0, 6, 0,
    //    0, 0, 5, 0, 0, 7, 8, 1, 0,
    //    0, 0, 4, 3, 0, 1, 0, 0, 2,
    //    4, 7, 3, 0, 0, 0, 0, 0, 0,
    //    0, 2, 6, 4, 0, 5, 3, 7, 0,
    //    0, 0, 0, 0, 0, 0, 4, 8, 6,
    //    3, 0, 0, 8, 0, 4, 5, 0, 0,
    //    0, 6, 7, 1, 0, 0, 2, 0, 0,
    //    0, 4, 0, 5, 0, 2, 0, 0, 0,

    func testRows() {
        let matrix = Matrix(values: PuzzleExamples.easy, columns: 9)
        XCTAssertEqual(matrix.row(index: 0), [0, 0, 0, 2, 0, 8, 0, 6, 0])
        XCTAssertEqual(matrix.row(index: 1), [0, 0, 5, 0, 0, 7, 8, 1, 0])
        XCTAssertEqual(matrix.row(index: 2), [0, 0, 4, 3, 0, 1, 0, 0, 2])
        XCTAssertEqual(matrix.row(index: 3), [4, 7, 3, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(matrix.row(index: 4), [0, 2, 6, 4, 0, 5, 3, 7, 0])
        XCTAssertEqual(matrix.row(index: 5), [0, 0, 0, 0, 0, 0, 4, 8, 6])
        XCTAssertEqual(matrix.row(index: 6), [3, 0, 0, 8, 0, 4, 5, 0, 0])
        XCTAssertEqual(matrix.row(index: 7), [0, 6, 7, 1, 0, 0, 2, 0, 0])
        XCTAssertEqual(matrix.row(index: 8), [0, 4, 0, 5, 0, 2, 0, 0, 0])
    }

    func testInvalidRow() {
        let matrix = Matrix(values: PuzzleExamples.easy, columns: 9)
        XCTAssertEqual(matrix.row(index: -1), [])
        XCTAssertEqual(matrix.row(index: 10), [])
    }
}
