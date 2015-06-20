//
//  NEUClass.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/20/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import Foundation

class NEUClass {
    var term : Term?;
    var level : Level?;
    var attributes : [String]?;
    var instructor : String?;
    var scheduleType : String?;
    var title : String?;
    var crn : Int?
    var subject : Subject?
    var courseNumber : Int?
    var meetingTimes : [MeetingTime]?
    
    init() {
        
    }
    
    func toJsonString() -> String {
        let tmpString : String = self.subject!.rawValue;
        return "{ \"subject\" : \"" + tmpString + "\" }";
    }
    
    init(jsonDict : NSDictionary) {
        
        if jsonDict["term"] != nil {
            self.term = Term(rawValue: jsonDict["term"] as! String);
        }
        
        if (jsonDict["level"] != nil) {
            self.level = Level(rawValue: jsonDict["level"] as! String);
        }
        
        // TODO: Implement attriutes
        
        if jsonDict["instructor"] != nil {
            self.instructor = jsonDict["instructor"] as? String;
        }
        
        if jsonDict["title"] != nil {
            self.title = jsonDict["title"] as? String;
        }

        if jsonDict["crn"] != nil {
            self.crn = jsonDict["crn"] as? Int;
        }
        
        if jsonDict["subject"] != nil {
            self.subject = Subject(rawValue: jsonDict["subject"] as! String);
        }
        
        if (jsonDict["courseNumber"] != nil) {
            self.courseNumber = jsonDict["courseNumber"] as? Int;
        }
        
        // TODO: Implement Meeting times
        
    }
}