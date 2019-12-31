//
//  Sudoku.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import Matrix

public struct Configuration {
    public let columns: Int
    public let rows: Int
    public let squareColumns: Int
    public let squareRows: Int
    public let allowedValues: [String]

    public var cellCount: Int { columns * rows }

    public static let standard = Configuration(columns: 9, rows: 9, squareColumns: 3, squareRows: 3,
                                               allowedValues: (1...9).map(String.init))
}

public struct SudokuPuzzle {
    public let configuration: Configuration = .standard
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
        guard values.count == configuration.cellCount else {
            throw Error.invalidNumberOfCells
        }
        self.matrix = Matrix(values: values, columns: configuration.columns)
    }
}

