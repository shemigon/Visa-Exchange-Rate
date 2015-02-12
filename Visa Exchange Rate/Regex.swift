//
//  SwiftRegex.swift
//  SwiftRegex
//
//  Created by Gregory Todd Williams on 6/7/14.
//  Copyright (c) 2014 Gregory Todd Williams. All rights reserved.
//

import Foundation

infix operator =~ {}

func =~(string:String, pattern:String) -> [String] {
    let regex = NSRegularExpression(pattern: pattern, options: .allZeros | .CaseInsensitive | .DotMatchesLineSeparators, error: nil)
    let range = NSMakeRange(0, countElements(string))
    let matches = regex?.matchesInString(string, options: .allZeros, range: range) as [NSTextCheckingResult]
    
    var groupMatches = [String]()
    for match in matches {
        let rangeCount = match.numberOfRanges
        
        for group in 0..<rangeCount {
            groupMatches.append((string as NSString).substringWithRange(match.rangeAtIndex(group)))
        }
    }
    
    return groupMatches
}
