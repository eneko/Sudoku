// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Sudoku",
    products: [
        .executable(name: "sudoku", targets: ["Sudoku"]),
        .library(name: "SudokuKit", targets: ["SudokuKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/eneko/CommandRegistry", from: "0.0.0"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0"),
        .package(url: "https://github.com/scottrhoyt/SwiftyTextTable.git", from: "0.5.0")
    ],
    targets: [
        .target(
            name: "Sudoku",
            dependencies: ["CommandRegistry", "Rainbow", "SudokuKit"]),
        .target(
            name: "SudokuKit",
            dependencies: ["SwiftyTextTable"]),
        .testTarget(
            name: "SudokuTests",
            dependencies: ["Sudoku"]),
        .testTarget(
            name: "SudokuKitTests",
            dependencies: ["SudokuKit"]),
    ]
)
