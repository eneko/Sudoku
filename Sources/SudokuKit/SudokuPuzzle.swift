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

    public enum Error: Swift.Error {
        case invalidNumberOfCells
    }

    /// Initialize with a list of values.
    /// - Parameter values: List of string values
    public init(values: [String]) throws {
        let values = values.map {
            SudokuSolution.allowedValues.contains($0) ? $0 : nil
        }
        guard values.count == columns * rows else {
            throw Error.invalidNumberOfCells
        }
        self.matrix = Matrix(values: values, columns: columns)
    }
}

