//
//  RowSolver.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

public final class RowSolver: SudokuSolver {
    var solution: SudokuSolution

    public init(solution: SudokuSolution) {
        self.solution = solution
    }

    public func solve() throws -> SudokuSolution {
        for value in SudokuSolution.validValues {
            if let index = findCellIndex(for: value) {
                try solution.setCell(value: value, at: index)
            }
        }
        return solution
    }

    func findCellIndex(for value: String) -> Int? {
        let rows = solution.cells.partition(inGroupsOf: solution.columns)
        for (rowIndex, row) in rows.enumerated() {
            if let column = findColumnIndex(for: value, in: Array(row)) {
                return rowIndex * solution.columns + column
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
