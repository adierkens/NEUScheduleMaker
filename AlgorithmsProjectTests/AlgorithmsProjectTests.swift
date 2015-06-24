//
//  AlgorithmsProjectTests.swift
//  AlgorithmsProjectTests
//
//  Created by Adam Dierkens on 6/17/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit
import XCTest

class AlgorithmsProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        
        class PrintResultsHandler : ScheduleResultsHandler {
            
            var stop = false;
            
            func onSchedulesFound(schedules : [Schedule]) {
                println("Schedule count: \(schedules.count)")
                for schedule in schedules {
                    XCTAssertEqual(2, schedule.size(), "Schedule class size")
                }
                stop = true;
            }
            
            func newScheduleFound(schedule: Schedule) {
            
            }
        }
        
        var clsIndexes : [NEUClassIndex] = []
        var clsFilters : [ClassFilter] = []
        var handler = PrintResultsHandler()
        
        clsIndexes.append(NEUClassIndex(subject: Subject.ACCT, courseNumber: 4501))
        clsIndexes.append(NEUClassIndex(subject: Subject.ACCT, courseNumber: 2301))
        
        clsFilters.append(DayFilter(day: Day.Monday))
        
        var scheduleFinder = ScheduleFinder(clsIndexes: clsIndexes, filters : clsFilters)
        scheduleFinder.findMatchingSchedules(handler)
        
        while !handler.stop {
            
        }

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
