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
        precondition(values.count % columns == 0, "Matrix must be filled")
        self.cells = Array(values)
        self.columns = columns
        self.rows = values.count / columns
    }

    public var cellRange: Range<Int> {
        return (0..<cells.count)
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
