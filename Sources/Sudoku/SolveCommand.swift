//
//  SolveCommand.swift
//  Sudoku
//
//  Created by Eneko Alonso on 12/22/19.
//

import CommandRegistry
import SPMUtility
import SudokuKit
import Rainbow

final class SolveCommand: Command {
    let command = "solve"
    let overview = "Solve a given Sudoku puzzle"

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    static let easy = [
        0, 0, 0, 2, 0, 8, 0, 6, 0,
        0, 0, 5, 0, 0, 7, 8, 1, 0,
        0, 0, 4, 3, 0, 1, 0, 0, 2,
        4, 7, 3, 0, 0, 0, 0, 0, 0,
        0, 2, 6, 4, 0, 5, 3, 7, 0,
        0, 0, 0, 0, 0, 0, 4, 8, 6,
        3, 0, 0, 8, 0, 4, 5, 0, 0,
        0, 6, 7, 1, 0, 0, 2, 0, 0,
        0, 4, 0, 5, 0, 2, 0, 0, 0,
    ]

    static let medium = [
        0, 0, 0, 2, 0, 8, 0, 6, 0,
        0, 0, 5, 0, 0, 7, 0, 1, 0,
        0, 0, 4, 3, 0, 1, 0, 0, 2,
        4, 7, 3, 0, 0, 0, 0, 0, 0,
        0, 2, 6, 0, 0, 5, 3, 7, 0,
        0, 0, 0, 0, 0, 0, 4, 8, 6,
        3, 0, 0, 8, 0, 4, 0, 0, 0,
        0, 6, 0, 1, 0, 0, 2, 0, 0,
        0, 4, 0, 5, 0, 2, 0, 0, 0,
    ]

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
    }

    func run(with arguments: ArgumentParser.Result) throws {
        let sudoku = try SudokuPuzzle(cells: Self.medium)
        print("Loading Sudoku puzzle...")
        print(sudoku.renderTable())

        print("Setting initial values...")
        var solution = try SudokuSolution(puzzle: sudoku)
        print(solution.renderTable())

        print("Solving Sudoku puzzle...")
        while solution.isIncomplete {
            solution = try RowSolver(solution: solution).solve()
        }
        print(solution.renderTable())
    }
}
