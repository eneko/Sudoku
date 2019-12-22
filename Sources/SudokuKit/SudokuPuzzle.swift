//
//  Sudoku.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

public struct SudokuPuzzle {
    public let columns = 9
    public let rows = 9
    public let cells: [String?]
}

public enum SudokuError: Error {
    case invalidNumberOfCells
    case invalidColumn
    case invalidRow
}
