//
//  SquareSolver.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/27/19.
//

/// Square Solver logic:
/// - For each square in the puzzle
/// - Look for unsolved cells (those with more than one possible value)
/// - For each unsolved cell
/// - Determine if any of its values are possible anywhere else in the same square.
/// - If not, that value would be the solution for this cell
public final class SquareSolver: SudokuSolver {
    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
        for value in SudokuSolution.allowedValues {
            if let index = findCellIndex(for: value, in: solution) {
                print("SquareSolver setting \(value) at index \(index)")
                try solution.setCell(value: value, at: index)
                return true
            }
        }
        return false
    }

    func findCellIndex(for value: String, in solution: SudokuSolution) -> Int? {
        for (squareIndex, square) in solution.squares.enumerated() {
            if let index = findIndex(for: value, in: square) {
                print("SquareSolver found value \(value) at square \(squareIndex), offset \(index)")
                let squareRow = index / 3
                let squareColumn = index % 3
                let offset = squareRow * solution.matrix.columns + squareColumn
                return solution.cellIndex(forSquare: squareIndex) + offset
            }
        }
        return nil
    }

    func findIndex(for value: String, in region: [[String]]) -> Int? {
        // Find the first cell containing value as possible solution
        guard let firstIndex = region.firstIndex(where: { $0.contains(value) && $0.count > 1 }) else {
            return nil
        }
        // Check if any other cell contains the same value
        let remainingCells = region.dropFirst(firstIndex + 1)
        if remainingCells.contains(where: { $0.contains(value) }) {
            return nil
        }
        // No other cell can hold this value
        return firstIndex
    }
}
