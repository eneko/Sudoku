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
    let squareSide = 3

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

    // MARK: Initialization

    public init(puzzle: SudokuPuzzle) throws {
        let values = (1...puzzle.configuration.cellCount).map { _ in Self.allowedValues }
        matrix = Matrix(values: values, columns: puzzle.configuration.columns)
        try setCellsFromPuzzle(puzzle: puzzle)
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

    // MARK: Solved Puzzle

    public var isIncomplete: Bool {
        return matrix.cells.contains(where: { $0.count > 1 })
    }

    public var solvedPuzzle: SudokuPuzzle? {
        return try? SudokuPuzzle(values: matrix.cells.map { $0[0] })
    }

    // MARK: Value modifiers

    mutating func setCell(value: String, at index: Int) throws {
//        print("BEGIN Set value \(value) at index \(index) [\(column(for: index)),\(row(for: index))]")
        matrix.cells[index] = [value]
        print(renderTable(highlight: index))
        try remove(value: value, fromColumnWithCellIndex: index)
        try remove(value: value, fromRowWithCellIndex: index)
        try remove(value: value, fromSquareWithCellIndex: index)
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
        for cellIndex in matrix.cellRange where cellIndex != index && squareIndex(forCell: cellIndex) == squareIndex(forCell: index) {
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
            print("Set confirmed cell with value \(value) at index \(index)")
            try setCell(value: value, at: index)
        }
    }

    // MARK: Value fetchers

    var columns: [[[String]]] {
        return matrix.allColumns
    }

    var rows: [[[String]]] {
        return matrix.allRows
    }

    var squares: [[[String]]] {
        return (0...8).map {
            let index = cellIndex(forSquare: $0)
            return matrix.subMatrix(columns: squareSide, rows: squareSide, fromCell: index).cells
        }
    }

    // MARK: Index calculations

    func squareIndex(forCell index: Int) -> Int {
        let squareColumn = (index % matrix.columns) / squareSide
        let squareRow = (index / matrix.rows) / squareSide
        return squareSide * squareRow + squareColumn
    }

    func columnIndex(forSquare index: Int) -> Int {
        return matrix.columnIndex(forCell: cellIndex(forSquare: index))
    }

    func rowIndex(forSquare index: Int) -> Int {
        return matrix.rowIndex(forCell: cellIndex(forSquare: index))
    }

    func cellIndex(forSquare index: Int) -> Int {
        let row = index / squareSide
        let column = index % squareSide
        return squareSide * matrix.columns * row + squareSide * column
    }

    func cellIndex(forSquare index: Int, offset: Int) -> Int {
        let row = offset / squareSide
        let column = offset % squareSide
        return cellIndex(forSquare: index) + row * matrix.columns + column
    }

    func cellIndices(forSquare index: Int) -> [Int] {
        let squareCells = squareSide*squareSide
        return (0..<squareCells).map { self.cellIndex(forSquare: index, offset: $0)}
    }

    func cellIndex(forRow row: Int, column: Int) -> Int {
        return row * matrix.columns + column
    }

    func cellIndices(forRow row: Int) -> [Int] {
        return (0..<matrix.columns).map { self.cellIndex(forRow: row, column: $0) }
    }

    func cellIndices(forColumn column: Int) -> [Int] {
        return (0..<matrix.rows).map { self.cellIndex(forRow: $0, column: column) }
    }
}
