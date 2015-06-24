//
//  NEUClass.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/20/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import Foundation

func ==(lhs: NEUClassIndex, rhs: NEUClassIndex) -> Bool {
    return true;
}

class NEUClassIndex : Hashable {
    
    private var subject : Subject;
    private var courseNumber : Int;
    
    var hashValue : Int {
        get {
            return 1;
        }
    }
    
    init(subject : Subject, courseNumber : Int) {
        self.subject = subject;
        self.courseNumber = courseNumber;
    }
}

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
    
    private func addToJsonString(withKey : String, withValue : String) -> String {
        var tmpJson : String = "";
        tmpJson += "\"";
        tmpJson += withKey;
        tmpJson +=  "\" : \"" + withValue + "\"";
        
        return tmpJson;
    }
    
    private func addToJsonString(withKey : String, withValue : Int) -> String {
        return "\"" + withKey + "\" : " + String(withValue);
    }
    
    func toJsonString() -> String {
        let tmpString : String = self.subject!.rawValue;
        var prefix : String = "";
        
        var jsonString = "{";
        
        if (self.subject != nil && self.subject != Subject.ALL) {
            let subjectString : String = self.subject!.rawValue;
            jsonString += addToJsonString("subject", withValue: subjectString);
            prefix = ",";
        }
        
        if (self.term != nil && self.term != Term.ALL) {
            let termString : String = self.term!.rawValue;
            jsonString += prefix;
            jsonString += addToJsonString("term", withValue: termString);
            prefix = ",";
        }
        
        if (self.instructor != nil) {
            jsonString += prefix;
            jsonString += addToJsonString("instructor", withValue: self.instructor!);
            prefix = ",";
        }
        
        if (self.title != nil) {
            jsonString += prefix;
            jsonString += addToJsonString("title", withValue: self.title!);
            prefix = ",";
        }
        
        if (self.courseNumber != nil) {
            jsonString += prefix;
            jsonString += addToJsonString("courseNumber", withValue: self.courseNumber!);
            prefix = ",";
        }
        
        if (self.crn != nil) {
            jsonString += prefix;
            jsonString = addToJsonString("crn", withValue:self.crn!)
        }
        
        jsonString += "}";
        return jsonString;
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