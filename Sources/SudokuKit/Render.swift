//
//  File.swift
//  
//
//  Created by Eneko Alonso on 12/22/19.
//

import Foundation

public func renderSimple(sudoku: Sudoku, separator: String = "", empty: String = ".") -> String {
    let renderedRows: [String] = sudoku.allRows.map { row -> String in
        return row.map { $0 ?? empty }.joined(separator: separator)
    }
    return renderedRows.joined(separator: "\n")
}
