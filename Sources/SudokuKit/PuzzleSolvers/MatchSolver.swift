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
protocol MatchSolver: SudokuSolver {}

extension MatchSolver {
    func indicesForPurgeableCells(values: [String], in region: [[String]]) -> [Int] {
        var result: [Int] = []
        for (columnIndex, cell) in region.enumerated() where cell != values {
            if Set(cell).intersection(values).isEmpty == false {
                result.append(columnIndex)
            }
        }
        return result
    }

    func remove(values: [String], fromCell index: Int, in solution: inout SudokuSolution) throws {
        print(solution.renderTable(highlight: index, color: .red))
        for value in values where solution.matrix.cells[index].contains(value) {
            try solution.remove(value: value, fromCell: index)
        }
    }
}

public final class RowMatchSolver: MatchSolver {
    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
        var solutionUpdated = false
        for (rowIndex, row) in solution.rows.enumerated() {
            let histogram = row.histogram()
            for (values, matchCount) in histogram where matchCount > 1 && values.count == matchCount {
                let indices = indicesForPurgeableCells(values: values, in: row)
                for columnIndex in indices {
                    let cellIndex = columnIndex + rowIndex * solution.matrix.columns
                    print("RowMatchSolver removing values \(values.joined(separator: ",")) from cell \(cellIndex)")
                    try remove(values: values, fromCell: cellIndex, in: &solution)
                    solutionUpdated = true
                }
            }
        }
        return solutionUpdated
    }
}

public final class ColumnMatchSolver: MatchSolver {
    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
        var solutionUpdated = false
        for (columnIndex, column) in solution.columns.enumerated() {
            let histogram = column.histogram()
            for (values, matchCount) in histogram where matchCount > 1 && values.count == matchCount {
                let indices = indicesForPurgeableCells(values: values, in: column)
                for rowIndex in indices {
                    let cellIndex = columnIndex + rowIndex * solution.matrix.columns
                    print("ColumnMatchSolver removing values \(values.joined(separator: ",")) from cell \(cellIndex)")
                    try remove(values: values, fromCell: cellIndex, in: &solution)
                    solutionUpdated = true
                }
            }
        }
        return solutionUpdated
    }
}

public final class SquareMatchSolver: MatchSolver {
    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
        var solutionUpdated = false
        for (squareIndex, square) in solution.squares.enumerated() {
            let histogram = square.histogram()
            for (values, matchCount) in histogram where matchCount > 1 && values.count == matchCount {
                let indices = indicesForPurgeableCells(values: values, in: square)
                for index in indices {
                    let cellIndex = solution.cellIndex(forSquare: squareIndex, offset: index)
                    print("SquareMatchSolver removing values \(values.joined(separator: ",")) from cell \(cellIndex)")
                    try remove(values: values, fromCell: cellIndex, in: &solution)
                    solutionUpdated = true
                }
            }
        }
        return solutionUpdated
    }
}
