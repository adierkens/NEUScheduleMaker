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
    
    public func isFathomed(neuClass: NEUClass) -> Bool {
        return true;
    }
    
}

public class AfterTimeFilter : ClassFilter {
    public func isFathomed(neuClass: NEUClass) -> Bool {
        return true;
    }
}