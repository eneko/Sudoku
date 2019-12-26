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

    // https://www.websudoku.com/?set_id=7487318393
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

    // https://www.websudoku.com/?set_id=6134848333
    static let medium = [
        6, 3, 0, 0, 1, 0, 9, 0, 8,
        8, 0, 9, 0, 0, 3, 0, 1, 0,
        1, 5, 0, 0, 0, 0, 3, 4, 0,
        0, 0, 0, 9, 2, 0, 0, 0, 0,
        9, 0, 0, 0, 0, 0, 0, 0, 3,
        0, 0 ,0, 0, 3, 5, 0, 0, 0,
        0, 9, 6, 0, 0, 0, 0, 2, 7,
        0, 7, 0, 1, 0, 0, 5, 0, 4,
        3, 0, 4, 0, 5, 0, 0, 6, 9,
    ]

    // https://www.websudoku.com/?set_id=1157079631
    static let hard = [
        0, 0, 0, 3, 0, 0, 0, 8, 0,
        6, 8, 0, 1, 0, 7, 0, 0, 5,
        9, 0, 0, 0, 0, 0, 1, 0, 0,
        4, 0, 0, 0, 6, 1, 0, 0, 0,
        0, 0, 6, 8, 0, 2, 9, 0, 0,
        0, 0, 0, 7, 5, 0, 0, 0, 1,
        0, 0, 7, 0, 0, 0, 0, 0, 2,
        1, 0, 0, 2, 0, 8, 0, 4, 6,
        0, 6, 0, 0, 0, 4, 0, 0, 0,
    ]

    // https://www.websudoku.com/?set_id=17746088
    static let evil = [
        0, 0, 0, 0, 6, 0, 0, 9, 0,
        0, 1, 0, 3, 8, 0, 0, 0, 0,
        4, 3, 7, 0, 0, 0, 0, 0, 0,
        8, 0, 0, 0, 0, 0, 4, 0, 0,
        0, 2, 0, 7, 0, 5, 0, 6, 0,
        0, 0, 1, 0, 0, 0, 0, 0, 7,
        0, 0, 0, 0, 0, 0, 5, 3, 6,
        0, 0, 0, 0, 2, 4, 0, 1, 0,
        0, 6, 0, 0, 1, 0, 0, 0, 0,
    ]

    static let medium2 = [
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

    static let ninetyNineProblemsSudoku = [
        0, 0, 4, 8, 0, 0, 0, 1, 7,
        6, 7, 0, 9, 0, 0, 0, 0, 0,
        5, 0, 8, 0, 3, 0, 0, 0, 4,
        3, 0, 0, 7, 4, 0, 1, 0, 0,
        0, 6, 9, 0, 0, 0, 7, 8, 0,
        0, 0, 1, 0, 6, 9, 0, 0, 5,
        1, 0, 0, 0, 8, 0, 3, 0, 6,
        0, 0, 0, 0, 0, 6, 0, 9, 1,
        2, 4, 0, 0, 0, 1, 5, 0, 0,
    ]

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
    }

    func run(with arguments: ArgumentParser.Result) throws {
        let sudoku = try SudokuPuzzle(cells: Self.evil)
        print("======================================================".blue)
        print("Loading Sudoku puzzle".blue)
        print("======================================================".blue)
        print(sudoku.renderTable())

        print("======================================================".blue)
        print("Setting initial values".blue)
        print("======================================================".blue)
        var solution = try SudokuSolution(puzzle: sudoku)
        print(solution.renderTable())

        print("======================================================".blue)
        print("Solving Sudoku puzzle".blue)
        print("======================================================".blue)
        let solvers: [SudokuSolver] = [RowSolver(), ColumnSolver(), MatchSolver()]
        var iteration = 0
        iterations: while solution.isIncomplete {
            iteration += 1
            print("Iteration:", "\(iteration)".yellow)
            for solver in solvers {
                if try solver.solve(solution: &solution) {
                    continue iterations
                }
            }
            // All solvers failed
            break
        }
        if solution.isIncomplete {
            print("Unable to solve Sudoku puzzle after \(iteration-1) iterations".red)
        }
        else {
            print("Solved Sudoku puzzle in \(iteration) iterations ✅".green)
            print(solution.renderTable())
        }
    }
}
