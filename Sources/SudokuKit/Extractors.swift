//
//  Extractors.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

// MARK: Data extractors

extension SudokuPuzzle {
    public func column(index: Int) throws -> [String?] {
        guard index >= 0 && index < columns else {
            throw SudokuError.invalidColumn
        }
        let start = index
        let end = columns * rows
        return stride(from: start, to: end, by: columns).map { cells[$0] }
    }

    public var allColumns: [[String?]] {
        return (0..<columns).compactMap { try? column(index: $0) }
    }

    public func row(index: Int) throws -> [String?] {
        guard index >= 0 && index < columns else {
            throw SudokuError.invalidRow
        }
        let start = index * columns
        let end = start + columns
        return (start..<end).map { cells[$0] }
    }

    public var allRows: [[String?]] {
        return (0..<rows).compactMap { try? row(index: $0) }
    }
}
