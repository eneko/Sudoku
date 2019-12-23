//
//  SudokuSolver.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

public protocol SudokuSolver {
    init(solution: SudokuSolution)
    func solve() throws -> SudokuSolution
}
