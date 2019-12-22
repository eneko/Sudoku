//
//  Validators.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

extension Sudoku {
    public var isComplete: Bool {
        return cells.contains(nil) == false
    }
}
