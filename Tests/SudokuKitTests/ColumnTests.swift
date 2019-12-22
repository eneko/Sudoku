import XCTest
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

    func testColumns() throws {
        let sudoku = try SudokuPuzzle(cells: Sudokus.easy)
        XCTAssertEqual(try sudoku.column(index: 0), [nil, nil, nil, "4", nil, nil, "3", nil, nil])
        XCTAssertEqual(try sudoku.column(index: 1), [nil, nil, nil, "7", "2", nil, nil, "6", "4"])
        XCTAssertEqual(try sudoku.column(index: 2), [nil, "5", "4", "3", "6", nil, nil, "7", nil])
        XCTAssertEqual(try sudoku.column(index: 3), ["2", nil, "3", nil, "4", nil, "8", "1", "5"])
        XCTAssertEqual(try sudoku.column(index: 4), [nil, nil, nil, nil, nil, nil, nil, nil, nil])
        XCTAssertEqual(try sudoku.column(index: 5), ["8", "7", "1", nil, "5", nil, "4", nil, "2"])
        XCTAssertEqual(try sudoku.column(index: 6), [nil, "8", nil, nil, "3", "4", "5", "2", nil])
        XCTAssertEqual(try sudoku.column(index: 7), ["6", "1", nil, nil, "7", "8", nil, nil, nil])
        XCTAssertEqual(try sudoku.column(index: 8), [nil, nil, "2", nil, nil, "6", nil, nil, nil])
    }

    func testInvalidColumn() throws {
        let sudoku = try SudokuPuzzle(cells: Sudokus.easy)
        XCTAssertThrowsError(try sudoku.column(index: -1))
        XCTAssertThrowsError(try sudoku.column(index: 10))
    }
}
