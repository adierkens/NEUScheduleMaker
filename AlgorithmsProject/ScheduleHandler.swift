//
//  ScheduleHandler.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/23/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import Foundation

class Schedule {
    var filters : [ClassFilter]?
    var allFilteredClassTimes : [NEUClassIndex : [NEUClass]]?
    
    func generate() -> [NEUClass]? {
        self.allFilteredClassTimes = getFilteredClasses();
        return generate([], selectionIndex: 0);
    }
    
    
    func generate(tmpSelected : [NEUClass], selectionIndex : Int) -> [NEUClass]? {
        
        var possibleClasses : [NEUClass] = allFilteredClassTimes[tmpSelected.count];
        
        if (possibleClasses == nil) {
            return nil;
        }
        
        var proposedClass : NEUClass = possibleClasses[selectionIndex];
        
        if willCauseConflict(tmpSelected, proposedClass) {
            return generate(tmpSelected, selectionIndex: selectionIndex+1) == nil
        } else {
            tmpSelected.append(proposedClass);
            return generate(tmpSelected, selectionIndex: 0);
        }
        
        
    }
    
}

    func getFilteredClasses() -> [NEUClass]{
        return [];
    }
    

    func willCauseConflict(classList : [NEUClass], neuclass : NEUClass) -> Bool {
        return true;
    }

    func removeConflicts() {
    }
    
}

class ClassFilter {
    
}

class NEUClassIndex {
    
}