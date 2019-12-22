import XCTest
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

    func testRows() throws {
        let sudoku = try Sudoku(cells: Sudokus.easy)
        XCTAssertEqual(try sudoku.row(index: 0), [nil, nil, nil, "2", nil, "8", nil, "6", nil])
        XCTAssertEqual(try sudoku.row(index: 1), [nil, nil, "5", nil, nil, "7", "8", "1", nil])
        XCTAssertEqual(try sudoku.row(index: 2), [nil, nil, "4", "3", nil, "1", nil, nil, "2"])
        XCTAssertEqual(try sudoku.row(index: 3), ["4", "7", "3", nil, nil, nil, nil, nil, nil])
        XCTAssertEqual(try sudoku.row(index: 4), [nil, "2", "6", "4", nil, "5", "3", "7", nil])
        XCTAssertEqual(try sudoku.row(index: 5), [nil, nil, nil, nil, nil, nil, "4", "8", "6"])
        XCTAssertEqual(try sudoku.row(index: 6), ["3", nil, nil, "8", nil, "4", "5", nil, nil])
        XCTAssertEqual(try sudoku.row(index: 7), [nil, "6", "7", "1", nil, nil, "2", nil, nil])
        XCTAssertEqual(try sudoku.row(index: 8), [nil, "4", nil, "5", nil, "2", nil, nil, nil])
    }

    func testInvalidRow() throws {
        let sudoku = try Sudoku(cells: Sudokus.easy)
        XCTAssertThrowsError(try sudoku.row(index: -1))
        XCTAssertThrowsError(try sudoku.row(index: 10))
    }
}
