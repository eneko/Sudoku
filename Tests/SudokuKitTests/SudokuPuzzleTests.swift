import XCTest
import SudokuKit

final class SudokuPuzzleTests: XCTestCase {
    func testSudokuPuzzle() throws {
        let sudoku = try SudokuPuzzle(cells: Sudokus.easy)
        XCTAssertEqual(sudoku.cells[3], "2")
    }
}
