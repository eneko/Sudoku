import XCTest
import Matrix
import SudokuKit

final class ColumnTests: XCTestCase {
    //    0, 0, 0, 2, 0, 8, 0, 6, 0,
    //    0, 0, 5, 0, 0, 7, 8, 1, 0,
    //    0, 0, 4, 3, 0, 1, 0, 0, 2,
    //    4, 7, 3, 0, 0, 0, 0, 0, 0,
    //    0, 2, 6, 4, 0, 5, 3, 7, 0,
    //    0, 0, 0, 0, 0, 0, 4, 8, 6,
    //    3, 0, 0, 8, 0, 4, 5, 0, 0,
    //    0, 6, 7, 1, 0, 0, 2, 0, 0,
    //    0, 4, 0, 5, 0, 2, 0, 0, 0,

    func testColumns() {
        let matrix = Matrix(values: PuzzleExamples.easy, columns: 9)
        XCTAssertEqual(matrix.column(index: 0), [0, 0, 0, 4, 0, 0, 3, 0, 0])
        XCTAssertEqual(matrix.column(index: 1), [0, 0, 0, 7, 2, 0, 0, 6, 4])
        XCTAssertEqual(matrix.column(index: 2), [0, 5, 4, 3, 6, 0, 0, 7, 0])
        XCTAssertEqual(matrix.column(index: 3), [2, 0, 3, 0, 4, 0, 8, 1, 5])
        XCTAssertEqual(matrix.column(index: 4), [0, 0, 0, 0, 0, 0, 0, 0, 0])
        XCTAssertEqual(matrix.column(index: 5), [8, 7, 1, 0, 5, 0, 4, 0, 2])
        XCTAssertEqual(matrix.column(index: 6), [0, 8, 0, 0, 3, 4, 5, 2, 0])
        XCTAssertEqual(matrix.column(index: 7), [6, 1, 0, 0, 7, 8, 0, 0, 0])
        XCTAssertEqual(matrix.column(index: 8), [0, 0, 2, 0, 0, 6, 0, 0, 0])
    }

    func testInvalidColumn() {
        let matrix = Matrix(values: PuzzleExamples.easy, columns: 9)
        XCTAssertEqual(matrix.column(index: -1), [])
        XCTAssertEqual(matrix.column(index: 10), [])
    }
}
