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

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
    }

    func run(with arguments: ArgumentParser.Result) throws {
        let sudoku = try SudokuPuzzle(integers: PuzzleExamples.evil)
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
        let solvers: [SudokuSolver] = [RowSolver(), ColumnSolver(), SquareSolver(), MatchSolver()]
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
            print(solution.renderTable())
        }
        else {
            print("Solved Sudoku puzzle in \(iteration) iterations ✅".green)
            print(solution.renderTable())
        }
    }
}
