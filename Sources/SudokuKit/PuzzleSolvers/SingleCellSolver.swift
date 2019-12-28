//
//  SquareSolver.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/27/19.
//

/// Single Cell Solver logic:
/// - For each row/column/square in the puzzle
/// - Look for unsolved cells (those with more than one possible value)
/// - For each unsolved cell
/// - Determine if any of its values are possible anywhere else in the same row/column/square.
/// - If not, that value would be the solution for this cell
protocol SingleCellSolver: SudokuSolver {}

extension SingleCellSolver {
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

public final class RowSolver: SingleCellSolver {
    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
        for value in SudokuSolution.allowedValues {
            for (rowIndex, row) in solution.rows.enumerated() {
                if let columnIndex = findIndex(for: value, in: row) {
                    let cellIndex = solution.cellIndex(forRow: rowIndex, column: columnIndex)
                    print("RowSolver setting \(value) at index \(cellIndex)")
                    try solution.setCell(value: value, at: cellIndex)
                    return true
                }
            }
        }
        return false
    }
}

public final class ColumnSolver: SingleCellSolver {
    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
        for value in SudokuSolution.allowedValues {
            for (columnIndex, column) in solution.columns.enumerated() {
                if let rowIndex = findIndex(for: value, in: column) {
                    let cellIndex = solution.cellIndex(forRow: rowIndex, column: columnIndex)
                    print("ColumnSolver setting \(value) at index \(cellIndex)")
                    try solution.setCell(value: value, at: cellIndex)
                    return true
                }
            }
        }
        return false
    }
}

public final class SquareSolver: SingleCellSolver {
    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
        for value in SudokuSolution.allowedValues {
            for (squareIndex, square) in solution.squares.enumerated() {
                if let index = findIndex(for: value, in: square) {
                    let cellIndex = solution.cellIndex(forSquare: squareIndex, offset: index)
                    print("SquareSolver setting \(value) at index \(cellIndex)")
                    try solution.setCell(value: value, at: cellIndex)
                    return true
                }
            }
        }
        return false
    }
}
