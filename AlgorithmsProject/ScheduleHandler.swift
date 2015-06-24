//
//  ScheduleHandler.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/23/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import Foundation

public class Schedule {
    private var selectedClasses : [NEUClass]
    
    init() {
        self.selectedClasses = []
    }
    
    init(selectedClasses : [NEUClass]) {
        self.selectedClasses = selectedClasses;
    }
    
    func conflicts(neuClass : NEUClass) -> Bool {
        return false;
    }
    
    func add(neuClass : NEUClass) {
        self.selectedClasses.append(neuClass)
    }
    
    func size() -> Int {
        return self.selectedClasses.count;
    }
}

public protocol ScheduleResultsHandler {
    func onSchedulesFound(schedules : [Schedule]);
    func newScheduleFound(schedule : Schedule);
}

class ScheduleFinder : SearchResultsHandler {
    
    private var classFilters : [ClassFilter];
    private var classIndexes : [NEUClassIndex];
    private var resultsHandler : ScheduleResultsHandler?
    private var allFilteredClassData : [NEUClassIndex : [NEUClass]]
    private var foundSchedules : [Schedule]
    
    init(clsIndexes : [NEUClassIndex], filters : [ClassFilter]) {
        self.classFilters = filters;
        self.classIndexes = clsIndexes;
        self.allFilteredClassData = [:]
        self.foundSchedules = []
    }
    
    func findMatchingSchedules(scheduleResultsHandler : ScheduleResultsHandler) {
        self.resultsHandler = scheduleResultsHandler;
        getAllClassInstances()
    }

    private func findMatches() {
        findMatches(Schedule())
    }
    
    private func findMatches(schedule : Schedule) {
        
        if (schedule.selectedClasses.count == classIndexes.count) {
            foundSchedules.append(schedule)
            resultsHandler?.onSchedulesFound(foundSchedules)
            resultsHandler?.newScheduleFound(schedule)
            return
        }
        
        
        let nxtIndex : NEUClassIndex = allFilteredClassData.keys.array[schedule.selectedClasses.count];
        
        for cls in self.allFilteredClassData[nxtIndex]! {
            var tmpScheduleArray = schedule.selectedClasses;
            if (!schedule.conflicts(cls)) {
                tmpScheduleArray.append(cls)
                findMatches(Schedule(selectedClasses: tmpScheduleArray))
            }
        }
        
    }
    
    private func getAllClassInstances() {
        for neuClassIndex : NEUClassIndex in classIndexes {
            HttpDataHandler.startConnection(self, postData: neuClassIndex.toJsonString())
        }
    }
    
    internal func onNewData(neuClasses: [NEUClass]) {
        
        NSLog("Got new data");
        
        
        if neuClasses.count == 0 {
            return
        }
        
        // Get the ClassIndex
        let neuIndex = NEUClassIndex(neuClass: neuClasses[0])
        
        if (neuIndex == nil) {
            return;
        }
        
        if self.allFilteredClassData[neuIndex!] == nil {
            self.allFilteredClassData[neuIndex!] = []
        }
        
        for neuClass in neuClasses {
            var shouldAddClass = true;
            for filter in self.classFilters {
                
                if !shouldAddClass {
                    continue
                }
                
                if filter.isFathomed(neuClass) {
                    shouldAddClass = false;
                }
            }
            
            if shouldAddClass {
                self.allFilteredClassData[neuIndex!]?.append(neuClass)
            }
        }
        
        NSLog("FilteredClasses count \(self.allFilteredClassData.count)");
        if self.allFilteredClassData.count == classIndexes.count {
            findMatches()
        }
        
    }
}