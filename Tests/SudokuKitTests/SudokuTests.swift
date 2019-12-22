import XCTest
import SudokuKit

final class SudokuTests: XCTestCase {
    func testSudoku() throws {
        let sudoku = try SudokuPuzzle(cells: Sudokus.easy)
        XCTAssertEqual(sudoku.cells[3], "2")
    }
}
