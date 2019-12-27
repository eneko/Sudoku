import XCTest
import SudokuKit

final class SudokuPuzzleTests: XCTestCase {
    func testSudokuPuzzle() throws {
        let sudoku = try SudokuPuzzle(integers: PuzzleExamples.easy)
        XCTAssertEqual(sudoku.matrix.cells[3], "2")
    }
}
