//
//  main.swift
//  LeetCode Complete
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

func maxProfit(_ prices: [Int]) -> Int {
    var profit = 0
    if prices.count == 0 { return 0 }
    for i in 0 ..< prices.count - 1{
        if prices[i + 1] - prices[i] > 0 {
            profit += prices[i + 1] - prices[i]
        }
    }
    return profit
}

func containsDuplicates(_ nums: [Int]) -> Bool {
    return nums.count == Set(nums).count
}

func plusOne(_ digits: [Int]) -> [Int] {
    var result = Array(digits)
    result[result.count - 1] += 1
    if result[result.count - 1] == 10 {
        if result.count == 1 {
            return [1, 0]
        }
        result[result.count - 1] = 0
        result = plusOne(Array(result.dropLast()))
        result.append(0)
        return result
    } else {
        return result
    }
}

func moveZeroes(_ nums: inout [Int]) {
    var zeroCount = 0
    var i = 0
    while i < nums.count {
        if nums[i] == 0 {
            zeroCount += 1
            nums.remove(at: i)
        } else {
            i += 1
        }
    }
    let zerosArr = repeatElement(0, count: zeroCount)
    nums.append(contentsOf: zerosArr)
}

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var numsDict: [Int:Int] = [:]
    for (i, num) in nums.enumerated() {
        let complement = target - nums[i]
        if let complementIndex = numsDict[complement] {
            return [i, complementIndex].sorted(by: { (num1, num2) in
                return num1 < num2
            })
        } else {
            numsDict[num] = i
        }
    }
    return []
}

func isValidSudoku(_ board: [[Character]]) -> Bool {
    var rowsSet: Set<Character> = []
    var colsDict: [Int: Set<Character>] = [:]
    var quadDict: [Int: Set<Character>] = [:]
    for i in 0..<9 {
        colsDict[i] = []
        quadDict[i] = []
    }
    for row in 0..<9 {
        for col in 0..<9 {
            // Handle Rows
            if board[row][col] == Character(".") { continue }
            if rowsSet.contains(board[row][col]) {
                return false
            } else {
                rowsSet.insert(board[row][col])
            }
            
            // Handle Columns
            if colsDict[col]!.contains(board[row][col]) {
                return false
            } else {
                colsDict[col]!.insert(board[row][col])
            }
            
            // Handle Quadrants
            let currentQ = ((row / 3) * 3) + (col / 3)
            if quadDict[currentQ]!.contains(board[row][col]) {
                return false
            } else {
                quadDict[currentQ]!.insert(board[row][col])
            }
        }
        rowsSet = []
    }
    return true
}

func rotate(_ matrix: inout [[Int]]) {
    let n = matrix.count
    for i in 0..<n {
        for j in (i + 1)..<n {
            if (i != j) {
                // XOR Swap Trick
                matrix[i][j] = matrix[i][j] ^ matrix[j][i]
                matrix[j][i] = matrix[i][j] ^ matrix[j][i]
                matrix[i][j] = matrix[i][j] ^ matrix[j][i]
            }
        }
        matrix[i].reverse()
    }
}



