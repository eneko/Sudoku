import XCTest
import SudokuKit

final class SudokuTests: XCTestCase {
    func testSudoku() throws {
        let sudoku = try Sudoku(cells: Sudokus.easy)
        XCTAssertEqual(sudoku.cells[3], "2")
    }
}
