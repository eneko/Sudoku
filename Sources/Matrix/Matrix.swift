//
//  Matrix.swift
//  Matrix
//
//  Created by Eneko Alonso on 12/26/19.
//

public struct Matrix<T: Collection> {
    public let columns: Int
    public let rows: Int

    public var cells: Array<T.Element> {
        didSet {
            precondition(cells.count == columns * rows, "Cannot update number of values")
        }
    }

    public init(values: T, columns: Int) {
        self.init(array: Array(values).compactMap { $0 }, columns: columns)
    }

    public init(array: Array<T.Element>, columns: Int) {
        self.cells = array
        self.columns = columns
        self.rows = cells.count / columns
        precondition(cells.count % columns == 0, "Matrix must be filled")
    }

    public var cellRange: Range<Int> {
        return (0..<cells.count)
    }

    public func subMatrix(columns: Int, rows: Int, fromCell index: Int) -> Matrix<T> {
        var values = Array<T.Element>()
        for row in 0..<rows {
            let start = index + (row * self.columns)
            let end = start + columns
            values.append(contentsOf: (start..<end).map { cells[$0] })
        }
        return Matrix(array: values, columns: columns)
    }

    public func column(index: Int) -> [T.Element] {
        guard index >= 0 && index < columns else {
            return []
        }
        let start = index
        let end = columns * rows
        return stride(from: start, to: end, by: columns).map { cells[$0] }
    }

    public var allColumns: [[T.Element]] {
        return (0..<columns).map { column(index: $0) }
    }

    public func row(index: Int) -> [T.Element] {
        guard index >= 0 && index < rows else {
            return []
        }
        let start = index * columns
        let end = start + columns
        return (start..<end).map { cells[$0] }
    }

    public var allRows: [[T.Element]] {
        return (0..<rows).map { row(index: $0) }
    }

    public func columnIndex(forCell index: Int) -> Int {
        return index % columns
    }

    public func rowIndex(forCell index: Int) -> Int {
        return index / rows
    }
}
