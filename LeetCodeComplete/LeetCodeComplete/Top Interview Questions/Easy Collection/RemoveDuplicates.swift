//
//  RemoveDuplicates.swift
//  LeetCodeComplete
//
//  Created by Orlando G. Rodriguez on 9/8/18.
//  Copyright © 2018 WorlySoftware. All rights reserved.
//

import Foundation

func removeDuplicates(_ nums: inout [Int]) -> Int {
    var last: Int?
    var index: Int = 0
    while index < nums.count {
        if nums[index] == last {
            nums.remove(at: index)
        } else {
            last = nums[index]
            index += 1
        }
    }
    return nums.count
}
