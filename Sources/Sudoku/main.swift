import CommandRegistry

var program = CommandRegistry(usage: "<subcommand> <options>", overview: "Sudoku command line tool")
program.register(command: GenerateCommand.self)
program.register(command: SolveCommand.self)
program.register(command: ValidateCommand.self)
program.run()
