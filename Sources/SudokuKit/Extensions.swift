//
//  Extensions.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import Darwin

// MARK: Array extensions

extension Array {
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
