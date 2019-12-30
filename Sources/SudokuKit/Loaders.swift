//
//  Loaders.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import Foundation
import Matrix

extension SudokuPuzzle {
    /// Load sudoku from a list of integers
    public init(integers: [Int]) throws {
        try self.init(values: integers.map(String.init))
    }

    /// Load sudoku from an input string.
    /// Currently the only format supported is a single string of 81 values.
    /// New lines and spaces are stripped from the input string.
    /// - Parameter string: Input string to parse
    public init(string: String) throws {
        let string = string.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
        try self.init(values: Array(string).map(String.init))
    }

    /// Load sudoku from file.
    /// Currently the only format supported is a single string of 81 values
    /// New lines and spaces are stripped from the input.
    /// - Parameter sudokuFile: Filepath for the input file
    public init(sudokuFile: URL) throws {
        let content = try String(contentsOf: sudokuFile, encoding: .utf8)
        try self.init(string: content)
    }
}
