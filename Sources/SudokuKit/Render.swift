//
//  Render.swift
//  SudokuKit
//
//  Created by Eneko Alonso on 12/22/19.
//

import SwiftyTextTable

extension SudokuPuzzle {
    public func values(empty: String = ".") -> [[String]] {
        return allRows.map { row in
            return row.map { $0 ?? empty }
        }
    }

    public func renderSimple(separator: String = "", empty: String = ".") -> String {
        return values(empty: empty)
            .map { $0.joined(separator: separator) }
            .joined(separator: "\n")
    }

    public func renderTable(empty: String = ".") -> String {
        var table = TextTable(columns: (1...columns).map { _ in TextTableColumn(header: "") })
        table.addRows(values: values(empty: empty))
        return table.render()
    }
}

extension SudokuSolution {
    public func values() -> [[String]] {
        return solution.map { $0.joined() }.partition(inGroupsOf: columns).map(Array.init)
    }

    public func renderTable() -> String {
        var table = TextTable(columns: (1...columns).map { _ in TextTableColumn(header: "") })
        table.addRows(values: values())
        return table.render()
    }
}
