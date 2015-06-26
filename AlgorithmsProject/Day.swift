//
//  Day.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/23/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import Foundation

enum Day : String {
    case Monday = "Monday";
    case Tuesday = "Tuesday";
    case Wednesday = "Wednesday";
    case Thursday = "Thursday";
    case Friday = "Friday";
    case Saturday = "Saturday";
    case Sunday = "Sunday";
    
    func toString() -> String {
        if self == Day.Thursday {
            return "R";
        }
        
        return rawValue.substringToIndex(rawValue.startIndex.successor())
    }
}