//
//  SudokuSolution.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

public struct SudokuSolution {
    public static let validValues = (1...9).map(String.init)

    public let columns: Int
    public let rows: Int
    public var solution: [[String]] = []

    public enum Error: Swift.Error {
        case invalidCellSolution(value: String, index: Int)
    }

    public init(puzzle: SudokuPuzzle) throws {
        columns = puzzle.columns
        rows = puzzle.rows
        solution = cellRange.map { _ in Self.validValues }
        try setCellsFromPuzzle(puzzle: puzzle)
    }

    var cellRange: Range<Int> {
        return (0..<columns*rows)
    }

    mutating func setCellsFromPuzzle(puzzle: SudokuPuzzle) throws {
        for index in cellRange {
            guard let cell = puzzle.cells[index] else {
                continue
            }
            try setCell(value: cell, at: index)
        }
    }

    mutating func setCell(value: String, at index: Int) throws {
        guard solution[index].contains(value) else {
            throw Error.invalidCellSolution(value: value, index: index)
        }
        solution[index] = [value]
        try remove(value: value, fromColumnWithCellIndex: index)
        try remove(value: value, fromRowWithCellIndex: index)
        try remove(value: value, fromSquareWithCellIndex: index)
    }

    mutating func remove(value: String, fromColumnWithCellIndex index: Int) throws {
        for cellIndex in cellRange where cellIndex != index && column(for: cellIndex) == column(for: index) {
            solution[cellIndex].removeAll { $0 == value }
            guard solution[cellIndex].isEmpty == false else {
                throw Error.invalidCellSolution(value: value, index: index)
            }
        }
    }

    mutating func remove(value: String, fromRowWithCellIndex index: Int) throws {
        for cellIndex in cellRange where cellIndex != index && row(for: cellIndex) == row(for: index) {
            solution[cellIndex].removeAll { $0 == value }
            guard solution[cellIndex].isEmpty == false else {
                throw Error.invalidCellSolution(value: value, index: index)
            }
        }
    }

    mutating func remove(value: String, fromSquareWithCellIndex index: Int) throws {
        for cellIndex in cellRange where cellIndex != index && square(for: cellIndex) == square(for: index) {
            solution[cellIndex].removeAll { $0 == value }
            guard solution[cellIndex].isEmpty == false else {
                throw Error.invalidCellSolution(value: value, index: index)
            }
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
