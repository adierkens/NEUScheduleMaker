//
//  NEUClass.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/20/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import Foundation

public func ==(lhs: NEUClassIndex, rhs: NEUClassIndex) -> Bool {
    return lhs.subject == rhs.subject && lhs.courseNumber == rhs.courseNumber;
}

public class NEUClassIndex : Hashable {
    
    private var subject : Subject;
    private var courseNumber : Int;
    
    public var hashValue : Int {
        get {
            return (subject.rawValue + String(courseNumber)).hashValue;
        }
    }
    
    init(subject : Subject, courseNumber : Int) {
        self.subject = subject;
        self.courseNumber = courseNumber;
    }
    
    init?(neuClass : NEUClass) {
        if neuClass.courseNumber != nil && neuClass.subject != nil {
            self.subject = neuClass.subject!
            self.courseNumber = neuClass.courseNumber!
        } else {
            self.subject = Subject.ALL;
            self.courseNumber = 0;
            return nil;
        }
    }
    
    func toNEUClass() -> NEUClass {
        var neuCls = NEUClass();
        neuCls.courseNumber = self.courseNumber;
        neuCls.subject = self.subject;
        return neuCls;
    }
    
    func toJsonString() -> String {
        return toNEUClass().toJsonString();
    }
    
    func toString() -> String {
        return "\(subject.rawValue) \(courseNumber)"
    }
}

public func ==(lhs: NEUClass, rhs: NEUClass) -> Bool {
    return NEUClassIndex(neuClass: lhs) == NEUClassIndex(neuClass: rhs);
}

public class NEUClass : Equatable {
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
            jsonString += addToJsonString("crn", withValue:self.crn!)
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
        
        if jsonDict["meetingTimes"] != nil {
            self.meetingTimes = []
            
            let meetingTimes : NSArray = jsonDict["meetingTimes"] as! NSArray
            
            for var i=0; i<meetingTimes.count; i++ {
                let meetingTime : NSDictionary = meetingTimes[i] as! NSDictionary;
                self.meetingTimes?.append(MeetingTime(jsonDict: meetingTime))
            }
            
        }
        
    }
    
    func conflicts(neuClass: NEUClass) -> Bool {
        
        if (self.meetingTimes == nil || neuClass.meetingTimes == nil) {
            return false;
        }
        
        
        for sMeetingTime in self.meetingTimes! {
            for tMeetingTime in neuClass.meetingTimes! {
                
                // We only care about Class meetings for now
                
                if (sMeetingTime.type != MeetingTimeType.Class || tMeetingTime.type != MeetingTimeType.Class) {
                    continue;
                }
                
                if sMeetingTime.days == nil || tMeetingTime.days == nil {
                    continue;
                }
                
                // Check if any of the days overlap
                
                var shouldSkip = true;
                
                
                for d in sMeetingTime.days! {
                    if contains(tMeetingTime.days!, d) {
                        shouldSkip = false;
                    }
                }
                
                if shouldSkip {
                    continue;
                }
                
                
                if (sMeetingTime.startTime == nil || sMeetingTime.endTime == nil || tMeetingTime.startTime == nil || tMeetingTime.endTime == nil) {
                    continue;
                }
                
                if sMeetingTime.startTime!.timeIntervalSince1970 < tMeetingTime.startTime!.timeIntervalSince1970 {
                    if (sMeetingTime.endTime!.timeIntervalSince1970 > tMeetingTime.endTime!.timeIntervalSince1970) {
                        return true;
                    }
                }
                
                if sMeetingTime.startTime!.timeIntervalSince1970 > tMeetingTime.startTime!.timeIntervalSince1970 {
                    if (sMeetingTime.endTime!.timeIntervalSince1970 < tMeetingTime.endTime!.timeIntervalSince1970) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
}