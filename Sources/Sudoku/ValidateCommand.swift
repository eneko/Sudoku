//
//  ValidateCommand.swift
//  Sudoku
//
//  Created by Eneko Alonso on 12/22/19.
//

import CommandRegistry

class ValidateCommand: Command {
    let command = "validate"
    let overview = "Validate a given Sudoku puzzle"

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
    }

    func run(with arguments: ArgumentParser.Result) throws {
        print("TODO: Print if Sudoku solution is valid or not")
    }
}
