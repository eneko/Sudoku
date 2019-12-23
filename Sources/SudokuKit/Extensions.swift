//
//  Extensions.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

// MARK: Array extensions

extension Array {
    public func partition(inGroupsOf size: Int) -> [ArraySlice<Element>] {
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
}
