//
//  File.swift
//  
//
//  Created by Eneko Alonso on 12/22/19.
//

import XCTest
import SudokuKit

final class ArrayExtensionsTests: XCTestCase {

    func testPartitions() {
        let numbers = Array(1...10)
        let partitions = numbers.partition(inGroupsOf: 3)
        XCTAssertEqual(partitions.count, 4)
        XCTAssertEqual(partitions[0], [1,2,3])
        XCTAssertEqual(partitions[1], [4,5,6])
        XCTAssertEqual(partitions[2], [7,8,9])
        XCTAssertEqual(partitions[3], [10])
    }

}
