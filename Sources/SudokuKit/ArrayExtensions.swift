//
//  Extensions.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import Darwin

// MARK: Array extensions

extension Array {
    /// Split the array in groups of the same size. If the number of total elements is not multiple
    /// of the give group size, the last group will contain less elements than the rest.
    /// - Parameter size: number of elements on each group
    public func split(inGroupsOf size: Int) -> [ArraySlice<Element>] {
        var result: [ArraySlice<Element>] = []
        var startIndex = self.startIndex
        while startIndex < self.endIndex {
            let endIndex = Swift.min(startIndex.advanced(by: size), self.endIndex)
            let slice = self[startIndex..<endIndex]
            result.append(slice)
            startIndex = endIndex
        }
        return result
    }

    /// Treating the array as a two-dimensional matrix, each columns will be contain a list of
    /// array slices with each element on that column.
    /// - Parameter rowCount: Number of rows expected on each column
    public func splitInRows(columnCount: Int) -> [ArraySlice<Element>] {
        return split(inGroupsOf: columnCount)
    }

    /// Treating the array as a two-dimensional matrix, each column will contain a list of
    /// array slices an element from that column (one slice per row of 1 element).
    /// - Parameter rowCount: Number of rows expected on each column
    public func splitInColumns(columnCount: Int) -> [[ArraySlice<Element>]] {
        var columns: [[ArraySlice<Element>]] = []
        var startIndex = self.startIndex
        while startIndex < self.endIndex {
            let endIndex = startIndex.advanced(by: 1)
            let cellSlice = self[startIndex..<endIndex]
            let columnIndex = startIndex % columnCount
            if columnIndex == columns.count {
                columns.append([cellSlice])
            }
            else {
                columns[columnIndex].append(cellSlice)
            }
            startIndex = endIndex
        }
        return columns
    }

    public mutating func transpose() {
        let side = Int(sqrt(Double(count)))
        guard count == side * side else {
            assertionFailure("Can only transpose square matrices")
            return
        }
        guard side > 1 else {
            return
        }
        for row in 0..<side {
            for column in row..<side {
                let lower = column + (row * side)
                let upper = row + (column * side)
                swapAt(lower, upper)
            }
        }
    }

    public func transposed() -> [Element] {
        var copy = self
        copy.transpose()
        return copy
    }
}

extension Sequence where Element: Hashable {
    public func histogram() -> [Element: Int] {
        var result: [Element: Int] = [:]
        for item in self {
            result[item, default: 0] += 1
        }
        return result
    }
}
