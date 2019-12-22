//
//  Loaders.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

// MARK: Array of Int

extension SudokuPuzzle {
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
