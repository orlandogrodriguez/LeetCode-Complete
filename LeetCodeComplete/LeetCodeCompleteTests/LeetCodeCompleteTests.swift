//
//  LeetCodeCompleteTests.swift
//  LeetCodeCompleteTests
//
//  Created by Orlando G. Rodriguez on 9/8/18.
//  Copyright © 2018 WorlySoftware. All rights reserved.
//

import XCTest
@testable import LeetCodeComplete

class LeetCodeCompleteTests: XCTestCase {

    func testRemoveDuplicates() {
        var arr = [1, 2, 3, 4, 4, 5]
        let result = 5
        XCTAssertEqual(result, removeDuplicates(&arr))
    }
    
}
