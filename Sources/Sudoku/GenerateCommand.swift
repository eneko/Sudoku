import CommandRegistry

final class GenerateCommand: Command {
    let command = "generate"
    let overview = "Generate a new Sudoku puzzle"

    let subparser: ArgumentParser
    var subcommands: [Command] = []

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
    }

    func run(with arguments: ArgumentParser.Result) throws {
        print("TODO: Print generated Sudoku")
    }
}
