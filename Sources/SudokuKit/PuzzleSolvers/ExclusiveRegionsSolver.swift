//
//  ExclusiveRegionsSolver.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/28/19.
//

import Matrix

/// Exclusive Regions Solver logic:
/// - For each square, we analize its columns/rows to find values that
///   cannot exist in the other two columns/rows.
/// - These values must then be possible only in the analyzed column/row.
/// - Because of this, we can determine those values cannot exist in the
///   remaining cells for that column/row, outside of the square.
public final class ExclusiveRegionsSolver: SudokuSolver {
    public init() {}

    public func solve(solution: inout SudokuSolution) throws -> Bool {
        for (squareIndex, square) in solution.squares.enumerated() {
            let matrix = Matrix(values: square, columns: solution.squareSide)
            for columnIndex in 0..<matrix.columns {
                var otherColumns = matrix.allColumns
                otherColumns.remove(at: columnIndex)
                let nonPossibleValues = findNonPossibleValues(in: otherColumns.flatMap { $0 })
                let outerColumnIndex = solution.columnIndex(forSquare: squareIndex) + columnIndex
                let oppositeCells = cellIndices(forColumn: outerColumnIndex, excludingCellsInSquare: squareIndex, in: solution)
//                print("ExclusiveRegionsSolver analyzing square \(squareIndex) column \(columnIndex)")
//                print("  otherColumns: \(otherColumns)")
//                print("  nonPossibleValues: \(nonPossibleValues)")
//                print("  outerColumnIndex: \(outerColumnIndex)")
//                print("  oppositeCells: \(oppositeCells)")
//                print(solution.renderTable(highlight: oppositeCells.first, color: .yellow))
                try remove(values: nonPossibleValues, fromCells: oppositeCells, in: &solution)
            }
            for rowIndex in 0..<matrix.rows {
                var otherRows = matrix.allRows
                otherRows.remove(at: rowIndex)
                let nonPossibleValues = findNonPossibleValues(in: otherRows.flatMap { $0 })
                let outerRowIndex = solution.rowIndex(forSquare: squareIndex) + rowIndex
                let oppositeCells = cellIndices(forRow: outerRowIndex, excludingCellsInSquare: squareIndex, in: solution)
//                print("ExclusiveRegionsSolver analyzing square \(squareIndex) row \(rowIndex)")
//                print("  otherRows: \(otherRows)")
//                print("  nonPossibleValues: \(nonPossibleValues)")
//                print("  outerRowIndex: \(outerRowIndex)")
//                print("  oppositeCells: \(oppositeCells)")
//                print(solution.renderTable(highlight: oppositeCells.first, color: .yellow))
                try remove(values: nonPossibleValues, fromCells: oppositeCells, in: &solution)
            }
        }
        return false
    }

    func findNonPossibleValues(in region: [[String]]) -> [String] {
        return Array(Set(SudokuSolution.allowedValues).subtracting(region.flatMap { $0 }))
    }

    func cellIndices(forColumn column: Int, excludingCellsInSquare square: Int, in solution: SudokuSolution) -> [Int] {
        let columnIndices = Set(solution.cellIndices(forColumn: column))
        let squareIndices = Set(solution.cellIndices(forSquare: square))
        return Array(columnIndices.subtracting(squareIndices)).sorted()
    }

    func cellIndices(forRow row: Int, excludingCellsInSquare square: Int, in solution: SudokuSolution) -> [Int] {
        let rowIndices = Set(solution.cellIndices(forRow: row))
        let squareIndices = Set(solution.cellIndices(forSquare: square))
        return Array(rowIndices.subtracting(squareIndices)).sorted()
    }

    func remove(values: [String], fromCells cells: [Int], in solution: inout SudokuSolution) throws {
        try cells.forEach { try self.remove(values: values, fromCell: $0, in: &solution) }
    }

    func remove(values: [String], fromCell index: Int, in solution: inout SudokuSolution) throws {
        for value in values where solution.matrix.cells[index].contains(value) {
            print("ExclusiveRegionsSolver removing value \(value) from cell \(index)")
            print(solution.renderTable(highlight: index, color: .red))
            try solution.remove(value: value, fromCell: index)
        }
    }
}
