//
//  MeetingTime.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/20/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import Foundation

class MeetingTime {
    var days : [Day]?
    var startTime : NSDate?
    var endTime : NSDate?
    var type : MeetingTimeType?
    var whr : String?
    var capacity : Int?
    var actual : Int?
    var seats : Int?
    var roomSize : Int?
    
    init(jsonDict : NSDictionary) {
        var dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "h:mm a"
        
        if jsonDict["startTime"] != nil {
            var startTimeString = jsonDict["startTime"] as? String;
            startTimeString = startTimeString?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            startTime = dateFormatter.dateFromString(startTimeString!)
        }
        
        if jsonDict["endTime"] != nil {
            var endTimeString = jsonDict["endTime"] as? String;
            endTimeString = endTimeString?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            endTime = dateFormatter.dateFromString(endTimeString!)
        }
        
        if jsonDict["type"] != nil {
            type = MeetingTimeType(rawValue: (jsonDict["type"] as? String)!);
        }
        
        if jsonDict["days"] != nil {
            var dayStrings : NSArray = jsonDict["days"] as! NSArray;
            
            self.days = [];
            
            for var i=0; i<dayStrings.count; i++ {
                let tmpString : String = dayStrings[i] as! String;
                let day : Day = Day(rawValue: tmpString)!;
                self.days!.append(day);
            }
        }
        
        if jsonDict["where"] != nil {
            self.whr = jsonDict["where"] as? String;
        }
        
        if jsonDict["capacity"] != nil {
            self.capacity = jsonDict["capacity"] as? Int
        }
        
        if jsonDict["actual"] != nil {
            self.actual = jsonDict["actual"] as? Int
        }
        
        if jsonDict["seats"] != nil {
            self.seats = jsonDict["seats"] as? Int
        }
        
        if jsonDict["roomSize"] != nil {
            self.roomSize = jsonDict["roomSize"] as? Int
        }
    }
    
}

