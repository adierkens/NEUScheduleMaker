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
    var startTime : String?
    var endTime : String?
    var type : MeetingTimeType?
    var whr : String?
    var capacity : Int?
    var actual : Int?
    var seats : Int?
    var roomSize : Int?
    
    init(jsonDict : NSDictionary) {
        
        if jsonDict["startTime"] != nil {
            startTime = jsonDict["startTime"] as? String;
        }
        
        if jsonDict["endTime"] != nil {
            endTime = jsonDict["endTime"] as? String;
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

