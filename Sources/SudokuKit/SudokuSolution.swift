//
//  SudokuSolution.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import Foundation

public struct SudokuSolution {
    public static let validValues = (1...9).map(String.init)

    public let columns: Int
    public let rows: Int
    public var cells: [[String]] = []

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
        columns = puzzle.columns
        rows = puzzle.rows
        cells = cellRange.map { _ in Self.validValues }
        try setCellsFromPuzzle(puzzle: puzzle)
    }

    var cellRange: Range<Int> {
        return (0..<columns*rows)
    }

    public var isIncomplete: Bool {
        return cells.contains(where: { $0.count > 1 })
    }

    mutating func setCellsFromPuzzle(puzzle: SudokuPuzzle) throws {
        for index in cellRange {
            guard let value = puzzle.matrix.cells[index] else {
                continue
            }
            print("Set initial value \(value) at index \(index)")
            try setCell(value: value, at: index)
        }
    }

    mutating func setCell(value: String, at index: Int) throws {
//        print("BEGIN Set value \(value) at index \(index) [\(column(for: index)),\(row(for: index))]")
        cells[index] = [value]
        try remove(value: value, fromColumnWithCellIndex: index)
        try remove(value: value, fromRowWithCellIndex: index)
        try remove(value: value, fromSquareWithCellIndex: index)
        print(renderTable(highlight: index))
//        print("END Set value \(value) at index \(index) [\(column(for: index)),\(row(for: index))]")
    }

    mutating func remove(value: String, fromColumnWithCellIndex index: Int) throws {
        for cellIndex in cellRange where cellIndex != index && column(for: cellIndex) == column(for: index) {
            try remove(value: value, fromCell: cellIndex)
        }
    }

    mutating func remove(value: String, fromRowWithCellIndex index: Int) throws {
        for cellIndex in cellRange where cellIndex != index && row(for: cellIndex) == row(for: index) {
            try remove(value: value, fromCell: cellIndex)
        }
    }

    mutating func remove(value: String, fromSquareWithCellIndex index: Int) throws {
        for cellIndex in cellRange where cellIndex != index && square(for: cellIndex) == square(for: index) {
            try remove(value: value, fromCell: cellIndex)
        }
    }

    mutating func remove(value: String, fromCell index: Int) throws {
        guard cells[index].contains(value) else {
            return
        }
        cells[index].removeAll { $0 == value }
        guard cells[index].isEmpty == false else {
            print(renderTable())
            throw Error.invalidCellSolution(value: value, index: index)
        }
        if cells[index].count == 1 {
            // Recursively remove candidates when only one value is left
            let value = cells[index][0]
            print("Set confirmed cell with value \(value) at index \(index)", cells[index])
            try setCell(value: value, at: index)
        }
    }

    func column(for index: Int) -> Int {
        return index % columns
    }

    func row(for index: Int) -> Int {
        return index / rows
    }

    func square(for index: Int) -> (squareColumn: Int, squareRow: Int) {
        let squareColumn = (index % columns) / 3
        let squareRow = (index / rows) / 3
        return (squareColumn: squareColumn, squareRow: squareRow)
    }
}
