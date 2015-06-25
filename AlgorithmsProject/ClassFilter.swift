//
//  ClassFilter.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/23/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import Foundation

let NoFridayClassFilter = DayFilter(day: Day.Friday)


public protocol ClassFilter {
    func isFathomed(neuClass : NEUClass) -> Bool;
}

public class DayFilter : ClassFilter {
    private var day : Day;
    
    init(day : Day) {
        self.day = day;
    }
    
    public func isFathomed(neuClass: NEUClass) -> Bool {
        
        if (neuClass.meetingTimes == nil) {
            return false;
        }
        
        for mt : MeetingTime in neuClass.meetingTimes! {
            
            if (mt.type == MeetingTimeType.Class) {
                
                if (mt.days == nil) {
                    continue
                }
                
                if contains(mt.days!, day) {
                    return true;
                }
            }
        }
        return false;
    }
}

public class BeforeTimeFilter : ClassFilter {
    
    var date : NSDate
    
    init(nsDate : NSDate) {
        date = nsDate;
    }
    
    public func isFathomed(neuClass: NEUClass) -> Bool {
        
        if neuClass.meetingTimes == nil {
            return false;
        }
        
        for mt in neuClass.meetingTimes! {
            
            if mt.type != MeetingTimeType.Class {
                continue
            }
            
            if mt.startTime == nil {
                continue
            }
            
            if mt.startTime!.timeIntervalSince1970 < date.timeIntervalSince1970 {
                return true;
            }
        }
        
        return false;
    }
    
}

public class AfterTimeFilter : ClassFilter {
    
    var date : NSDate;
    
    init(nsDate : NSDate) {
        date = nsDate;
    }
    
    public func isFathomed(neuClass: NEUClass) -> Bool {
        if neuClass.meetingTimes == nil {
            return false;
        }
        
        for mt in neuClass.meetingTimes! {
            
            if mt.type != MeetingTimeType.Class {
                continue
            }
            
            if mt.endTime == nil {
                continue
            }
            
            if mt.endTime!.timeIntervalSince1970 > date.timeIntervalSince1970 {
                return true;
            }
        }
        
        return false;
    }
}