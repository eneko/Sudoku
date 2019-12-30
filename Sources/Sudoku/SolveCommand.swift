//
//  SolveCommand.swift
//  Sudoku
//
//  Created by Eneko Alonso on 12/22/19.
//

import Foundation
import CommandRegistry
import SPMUtility
import SudokuKit
import Rainbow

final class SolveCommand: Command {
    let command = "solve"
    let overview = "Solve a given Sudoku puzzle"

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    let stringInput: OptionArgument<String>
    let puzzleFilePath: OptionArgument<String>

    enum Error: Swift.Error {
        case noInput
    }

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
        stringInput = subparser.add(option: "--string", shortName: "-s", kind: String.self, usage: "String input with Sudoku puzzle", completion: nil)
        puzzleFilePath = subparser.add(option: "--input-file", shortName: "-i", kind: String.self, usage: "File path containing Sudoku puzzle", completion: nil)
    }

    func run(with arguments: ArgumentParser.Result) throws {
        if let string = arguments.get(stringInput) {
            try solve(sudoku: SudokuPuzzle(string: string))
        }
        else if let path = arguments.get(puzzleFilePath) {
            try solve(sudoku: SudokuPuzzle(sudokuFile: URL(fileURLWithPath: path)))
        }
        else {
            throw Error.noInput
        }
    }

    func solve(sudoku: SudokuPuzzle) throws {
        print("======================================================".blue)
        print("Loading Sudoku puzzle".blue)
        print("======================================================".blue)
        print(sudoku.renderTable())

        print("======================================================".blue)
        print("Setting initial values".blue)
        print("======================================================".blue)
        var solution = try SudokuSolution(puzzle: sudoku)
        print("Finished loading puzzle:")
        print(solution.renderTable())

        print("======================================================".blue)
        print("Solving Sudoku puzzle".blue)
        print("======================================================".blue)
        let solvers: [SudokuSolver] = [
            RowSolver(),
            ColumnSolver(),
            SquareSolver(),
            RowMatchSolver(),
            ColumnMatchSolver(),
            SquareMatchSolver(),
            ExclusiveRegionsSolver()
        ].reversed()
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
