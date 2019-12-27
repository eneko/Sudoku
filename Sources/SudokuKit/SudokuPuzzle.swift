//
//  Sudoku.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import Matrix

public struct SudokuPuzzle {
    public let columns = 9
    public let rows = 9
    public let matrix: Matrix<[String?]>

    public init(integers: [Int]) throws {
        guard integers.count == columns * rows else {
            throw SudokuError.invalidNumberOfCells
        }
        let values = integers.map { value -> String? in
            guard value != 0 else {
                return nil
            }
            return String(value)
        }
        self.matrix = Matrix(values: values, columns: columns)
    }
}

public enum SudokuError: Error {
    case invalidNumberOfCells
//    case invalidColumn
//    case invalidRow
}
