//
//  SudokuSolution.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import Foundation
import Matrix

public struct SudokuSolution {
    public static let allowedValues = (1...9).map(String.init)

    public private(set) var matrix: Matrix<[[String]]>

    public enum Error: Swift.Error, LocalizedError {
        case invalidCellSolution(value: String, index: Int)
        case valueNotFound(value: String, index: Int)

        public var errorDescription: String? {
            switch self {
            case .invalidCellSolution(let value, let index):
                return "Error: failed to set \(value) at index \(index)"
            case .valueNotFound(let value, let index):
                return "Error: value \(value) not found at index \(index)"
            }
        }
    }

    public init(puzzle: SudokuPuzzle) throws {
        let values = (1...puzzle.columns*puzzle.rows).map { _ in Self.allowedValues }
        matrix = Matrix(values: values, columns: puzzle.columns)
        try setCellsFromPuzzle(puzzle: puzzle)
    }

    public var isIncomplete: Bool {
        return matrix.cells.contains(where: { $0.count > 1 })
    }

    mutating func setCellsFromPuzzle(puzzle: SudokuPuzzle) throws {
        for index in matrix.cellRange {
            guard let value = puzzle.matrix.cells[index] else {
                continue
            }
            print("Set initial value \(value) at index \(index)")
            try setCell(value: value, at: index)
        }
    }

    mutating func setCell(value: String, at index: Int) throws {
//        print("BEGIN Set value \(value) at index \(index) [\(column(for: index)),\(row(for: index))]")
        matrix.cells[index] = [value]
        try remove(value: value, fromColumnWithCellIndex: index)
        try remove(value: value, fromRowWithCellIndex: index)
        try remove(value: value, fromSquareWithCellIndex: index)
        print(renderTable(highlight: index))
//        print("END Set value \(value) at index \(index) [\(column(for: index)),\(row(for: index))]")
    }

    mutating func remove(value: String, fromColumnWithCellIndex index: Int) throws {
        for cellIndex in matrix.cellRange where cellIndex != index && matrix.columnIndex(forCell: cellIndex) == matrix.columnIndex(forCell: index) {
            try remove(value: value, fromCell: cellIndex)
        }
    }

    mutating func remove(value: String, fromRowWithCellIndex index: Int) throws {
        for cellIndex in matrix.cellRange where cellIndex != index && matrix.rowIndex(forCell: cellIndex) == matrix.rowIndex(forCell: index) {
            try remove(value: value, fromCell: cellIndex)
        }
    }

    mutating func remove(value: String, fromSquareWithCellIndex index: Int) throws {
        for cellIndex in matrix.cellRange where cellIndex != index && squareIndices(forCell: cellIndex) == squareIndices(forCell: index) {
            try remove(value: value, fromCell: cellIndex)
        }
    }

    mutating func remove(value: String, fromCell index: Int) throws {
        guard matrix.cells[index].contains(value) else {
            return
        }
        matrix.cells[index].removeAll { $0 == value }
        guard matrix.cells[index].isEmpty == false else {
            print(renderTable())
            throw Error.invalidCellSolution(value: value, index: index)
        }
        if matrix.cells[index].count == 1 {
            // Recursively remove candidates when only one value is left
            let value = matrix.cells[index][0]
            print("Set confirmed cell with value \(value) at index \(index)", matrix.cells[index])
            try setCell(value: value, at: index)
        }
    }

    func squareIndices(forCell index: Int) -> (squareColumn: Int, squareRow: Int) {
        let squareColumn = (index % matrix.columns) / 3
        let squareRow = (index / matrix.rows) / 3
        return (squareColumn: squareColumn, squareRow: squareRow)
    }
}
