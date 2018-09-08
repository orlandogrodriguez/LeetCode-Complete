//
//  Easy Collection - Strings.swift
//  LeetCode Complete
//
//  Created by Orlando G. Rodriguez on 9/8/18.
//  Copyright © 2018 WorlySoftware. All rights reserved.
//
import Foundation

func reverseString(_ s: String) -> String {
    return String(s.reversed())
}

func reverse(_ x: Int) -> Int {
    var result = 0
    var current = abs(x)
    while current > 0 {
        result *= 10
        let remainder = current % 10
        current -= remainder
        result += remainder
        current /= 10
    }
    result = x < 0 ? result * -1 : result
    if abs(result) > (2 << 31) - 1 { return 0 }
    return result
}

func firstUniqChar(_ s: String) -> Int {
    var charDict: [Character: Int] = [:]
    for char in s {
        if  charDict[char] != nil {
            charDict[char]! += 1
        } else {
            charDict[char] = 1
        }
    }
    var lowestIndex = s.count
    for entry in charDict {
        let indexInt = s.distance(from: s.startIndex, to: s.index(of: entry.key)!)
        if entry.value == 1 && indexInt < lowestIndex {
            lowestIndex = indexInt
        }
    }
    
    if lowestIndex == s.count {
        return -1
    } else {
        return lowestIndex
    }
}

func isAnagram(_ s: String, _ t: String) -> Bool {
    if s.count != t.count { return false }
    var sDict = [Character:Int]()
    var tDict = [Character:Int]()
    for c in s {
        if sDict[c] != nil {
            sDict[c]! += 1
        } else {
            sDict[c] = 1
        }
    }
    for c in t {
        if tDict[c] != nil {
            tDict[c]! += 1
        } else {
            tDict[c] = 1
        }
    }
    for entry in sDict {
        if tDict[entry.key] != entry.value {
            return false
        }
    }
    return true
}

func isPalindrome(_ s: String) -> Bool {
    let strUnicode = s.lowercased().unicodeScalars
    let filteredStrUnicode = strUnicode.filter { (Int($0.value) >= 97 && Int($0.value) <= 122) ||
        (Int($0.value) >= 48 && Int($0.value) <= 57) }
    let filteredStr = String(filteredStrUnicode)
    return filteredStr == String(filteredStr.reversed())
}

func isPalindromeFast(_ s: String) -> Bool {
    let strUTF = s.lowercased().utf16
    let strInt = strUTF.map { Int($0) }
    var p1 = 0, p2 = strInt.count - 1
    while (p1 < p2) {
        if strInt[p1] == strInt[p2] {
            p1 += 1
            p2 -= 1
        } else {
            if !isLetterOrNumber(c: strInt[p1]) { p1 += 1; continue }
            if !isLetterOrNumber(c: strInt[p2]) { p2 -= 1; continue }
            return false
        }
    }
    return true
}
func isLetterOrNumber(c: Int) -> Bool {
    return (c >= 97 && c <= 122) || (c >= 48 && c <= 57)
}

func myAtoi(_ str: String) -> Int {
    // Step 0: Create array of utf16 representations of the characters in the string.
    var strUTF = str.utf16
    var strInt = strUTF.map { Int($0) }
    
    // Step 1: Find index of first series of consecutive numbers
    // Declare pointer variables
    var firstConsecutiveNumberIndex = -1
    var consecutiveNumberDistance = 0
    var isNegative = false
    
    // Iterate through the string
    for (i, c) in strInt.enumerated() {
        
        // If we encounter a number and it turns out to be the first number
        if isNumber(c) {
            if firstConsecutiveNumberIndex == -1 {
                firstConsecutiveNumberIndex = i
            }
            consecutiveNumberDistance += 1
        } else {
            if firstConsecutiveNumberIndex == -1 { // If we find something before finding a number
                if isSign(c) != 0 { // and it's either a '+' or a '-'
                    isNegative = isSign(c) == -1 ? true : false
                } else { // it's a letter or something that's not a number
                    if c == 32 { // if we got a space tho
                        continue // we're good
                    } else {
                        return 0
                    }
                }
            } else { // If we find something after having found numbers
                consecutiveNumberDistance = i - firstConsecutiveNumberIndex
                break
            }
        }
    }
    
    var numbersUTF16 = strInt.enumerated().filter { $0.0 >= firstConsecutiveNumberIndex && $0.0 < firstConsecutiveNumberIndex + consecutiveNumberDistance }
    var numbers = numbersUTF16.map { $0.1 - 48 }
    var result = 0
    while numbers.count > 0 {
        let exponent = numbers.count
        result += numbers[0] * myPow(10, exponent - 1)
        numbers = Array(numbers.dropFirst())
    }
    result = isNegative ? result * -1 : result
    if result < -1 * (2 << 30) {
        return -1 * (2 << 30)
    }
    if result > (2 << 30) - 1 {
        return (2 << 30) - 1
    }
    
    return result
}
func isSign(_ c: Int) -> Int { // returns -1 if negative, 1 if positive, and 0 if not a sign
    switch c {
    case 45: return -1
    case 43: return 1
    default: return 0
    }
}
func myPow(_ num1: Int, _ num2: Int) -> Int {
    var result = num1
    var count = num2
    if num2 == 1 { return num1 }
    if num2 == 0 { return 1 }
    while count > 1 {
        result *= num1
        count -= 1
    }
    return result
}
func isNumber(_ c: Int) -> Bool {
    return c >= 49 && c <= 57
}
