//
//  RowSolver.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

/// Row Solver logic:
/// - For each row in the puzzle
/// - Look for unsolved cells (those with more than one possible value)
/// - For each unsolved cell
/// - Determine if any of its values are possible anywhere else in the same row.
/// - If not, that value would be the solution for this cell
public final class RowSolver: SudokuSolver {
//    var solution: SudokuSolution
//
//    public init(solution: SudokuSolution) {
//        self.solution = solution
//    }

    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
//    public func solve() throws -> SudokuSolution {
        for value in SudokuSolution.validValues {
            if let index = findCellIndex(for: value, in: solution) {
                print("RowSolver setting \(value) at index \(index)")
                try solution.setCell(value: value, at: index)
                return true
            }
        }
        return false
    }

    func findCellIndex(for value: String, in solution: SudokuSolution) -> Int? {
        let rows = solution.cells.split(inGroupsOf: solution.columns)
        for (rowIndex, row) in rows.enumerated() {
            if let columnIndex = findColumnIndex(for: value, in: Array(row)) {
                return rowIndex * solution.columns + columnIndex
            }
        }
        return nil
    }

    func findColumnIndex(for value: String, in row: [[String]]) -> Int? {
        guard let firstIndex = row.firstIndex(where: { $0.contains(value) && $0.count > 1 }) else {
            return nil
        }
        let remaining = row.dropFirst(firstIndex + 1)
        if remaining.contains(where: { $0.contains(value) }) {
            return nil // found more than one candidate
        }
        return firstIndex
    }
}
