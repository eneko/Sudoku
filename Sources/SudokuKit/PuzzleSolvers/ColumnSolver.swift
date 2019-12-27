//
//  ColumnSolver.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/23/19.
//

/// Column Solver logic:
/// - For each row in the puzzle
/// - Look for unsolved cells (those with more than one possible value)
/// - For each unsolved cell
/// - Determine if any of its values are possible anywhere else in the same row.
/// - If not, that value would be the solution for this cell
public final class ColumnSolver: SudokuSolver {
    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
        for value in SudokuSolution.allowedValues {
            if let index = findCellIndex(for: value, in: solution) {
                print("ColumnSolver setting \(value) at index \(index)")
                try solution.setCell(value: value, at: index)
                return true
            }
        }
        return false
    }

    func findCellIndex(for value: String, in solution: SudokuSolution) -> Int? {
        let columns = solution.matrix.allColumns// cells.transposed().split(inGroupsOf: solution.columns)
        for (columnIndex, column) in columns.enumerated() {
            if let rowIndex = findRowIndex(for: value, in: Array(column)) {
                return rowIndex * solution.matrix.columns + columnIndex
            }
        }
        return nil
    }

    func findRowIndex(for value: String, in column: [[String]]) -> Int? {
        guard let firstIndex = column.firstIndex(where: { $0.contains(value) && $0.count > 1 }) else {
            return nil
        }
        let remaining = column.dropFirst(firstIndex + 1)
        if remaining.contains(where: { $0.contains(value) }) {
            return nil // found more than one candidate
        }
        return firstIndex
    }
}
