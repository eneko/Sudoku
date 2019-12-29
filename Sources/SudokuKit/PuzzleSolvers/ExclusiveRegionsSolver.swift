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
        var solutionUpdated = false
        for (squareIndex, square) in solution.squares.enumerated() {
            let matrix = Matrix(values: square, columns: solution.squareSide)
            let squareIndices = Set(solution.cellIndices(forSquare: squareIndex))

            for squareColumnIndex in 0..<matrix.columns {
                let columnIndex = solution.columnIndex(forSquare: squareIndex) + squareColumnIndex
                let columnIndices = Set(solution.cellIndices(forColumn: columnIndex))

                let exclusiveColumnCells = Array(columnIndices.subtracting(squareIndices)).sorted()
                let exclusiveSquareCells = Array(squareIndices.subtracting(columnIndices)).sorted()

                if try remove(values: findNonPossibleValues(inCells: exclusiveColumnCells, solution: solution), fromCells: exclusiveSquareCells, in: &solution) {
                    solutionUpdated = true
                }
                if try remove(values: findNonPossibleValues(inCells: exclusiveSquareCells, solution: solution), fromCells: exclusiveColumnCells, in: &solution) {
                    solutionUpdated = true
                }
            }

            for squareRowIndex in 0..<matrix.rows {
                let rowIndex = solution.rowIndex(forSquare: squareIndex) + squareRowIndex
                let rowIndices = Set(solution.cellIndices(forRow: rowIndex))

                let exclusiveRowCells = Array(rowIndices.subtracting(squareIndices)).sorted()
                let exclusiveSquareCells = Array(squareIndices.subtracting(rowIndices)).sorted()

                if try remove(values: findNonPossibleValues(inCells: exclusiveRowCells, solution: solution), fromCells: exclusiveSquareCells, in: &solution) {
                    solutionUpdated = true
                }
                if try remove(values: findNonPossibleValues(inCells: exclusiveSquareCells, solution: solution), fromCells: exclusiveRowCells, in: &solution) {
                    solutionUpdated = true
                }
            }
        }
        return solutionUpdated
    }

    func findNonPossibleValues(inCells indices: [Int], solution: SudokuSolution) -> [String] {
        let cells = indices.map { solution.matrix.cells[$0] }
        return Array(Set(SudokuSolution.allowedValues).subtracting(cells.flatMap { $0 }))
    }

    func remove(values: [String], fromCells cells: [Int], in solution: inout SudokuSolution) throws -> Bool {
        var solutionUpdated = false
        for cell in cells {
            if try self.remove(values: values, fromCell: cell, in: &solution) {
                solutionUpdated = true
            }
        }
        return solutionUpdated
    }

    func remove(values: [String], fromCell index: Int, in solution: inout SudokuSolution) throws -> Bool {
        var solutionUpdated = false
        for value in values where solution.matrix.cells[index].contains(value) {
            print("ExclusiveRegionsSolver removing value \(value) from cell \(index)")
            print(solution.renderTable(highlight: index, color: .red))
            try solution.remove(value: value, fromCell: index)
            solutionUpdated = true
        }
        return solutionUpdated
    }
}
