//
//  File.swift
//  
//
//  Created by Eneko Alonso on 12/22/19.
//

import Foundation

public struct Sudoku {
    public let columns = 9
    public let rows = 9

    public var cells: [String?] = []
}

public enum SudokuError: Error {
    case invalidNumberOfCells
    case invalidColumn
    case invalidRow
}

// MARK: Data extractors

extension Sudoku {
    public func column(index: Int) throws -> [String?] {
        guard index >= 0 && index < columns else {
            throw SudokuError.invalidColumn
        }
        let start = index
        let end = columns * rows
        return stride(from: start, to: end, by: columns).map { cells[$0] }
    }

    public func row(index: Int) throws -> [String?] {
        guard index >= 0 && index < columns else {
            throw SudokuError.invalidRow
        }
        let start = index * columns
        let end = start + columns
        return (start..<end).map { cells[$0] }
    }
}

// MARK: Array of Int

extension Sudoku {
    public init(cells: [Int]) throws {
        guard cells.count == columns * rows else {
            throw SudokuError.invalidNumberOfCells
        }
        self.cells = cells.map { value in
            guard value != 0 else {
                return nil
            }
            return String(value)
        }
    }
}
