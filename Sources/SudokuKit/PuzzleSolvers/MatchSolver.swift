//
//  MatchSolver.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/25/19.
//

/// Match Solver logic:
/// - Evaluates rows, columns and squares
/// - Looks for cells containting the same possible solutions
/// - If the number of cells matching is equal to the number of possible solutions,
///   that indicates those solutions cannot exist anywhere else in the row/column/square
public final class MatchSolver: SudokuSolver {
    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
        var solutionUpdated = false
        let rows = solution.cells.splitInRows(columnCount: solution.columns)
        for (rowIndex, row) in rows.enumerated() {
            let histogram = row.histogram()
            for (values, matchCount) in histogram where matchCount > 1 && values.count == matchCount {
                let indices = columnIndicesForPurgeableCells(values: values, in: row)
                //print("Match Solver found match \(key) on row \(rowIndex). Pruneable cells: \(indices)")
                for columnIndex in indices {
                    let cellIndex = columnIndex + rowIndex * solution.columns
                    try remove(values: values, fromCell: cellIndex, in: &solution)
                    solutionUpdated = true
                }
            }
        }
        return solutionUpdated
    }

    func columnIndicesForPurgeableCells(values: [String], in row: ArraySlice<[String]>) -> [Int] {
        var result: [Int] = []
        for (columnIndex, cell) in row.enumerated() where cell != values {
            if Set(cell).intersection(values).isEmpty == false {
                result.append(columnIndex)
            }
        }
        return result
    }

    func remove(values: [String], fromCell index: Int, in solution: inout SudokuSolution) throws {
        print("Match Solver removing values \(values.joined(separator: ",")) from cell \(index)")
        try values.forEach { try solution.remove(value: $0, fromCell: index) }
    }
}
