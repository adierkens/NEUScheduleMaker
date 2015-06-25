//
//  ScheduleResultsViewController.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/24/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class ScheduleResultsViewController: UIViewController {

    var pageIndex : Int?
    var pageCount : Int?
    var schedule : Schedule!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if (pageIndex != nil) {
            pageControl.numberOfPages = pageCount!;
            pageControl.currentPage = pageIndex!;
        }
        
        if self.schedule != nil {
            loadScheduleView()
        } else {
            schedule = Schedule()
        }
    }
    
    func loadScheduleView() {
        if self.schedule == nil {
            return;
        }
        
        for v in createGridViews() {
            view.addSubview(v);
        }
        
        for v in createClassSubViews() {
            view.addSubview(v)
        }
        
        UIView.commitAnimations();
    }
    
    private func createGridViews() -> [UIView] {
        var subViews : [UIView] = []
        var xVal = 0.0
        var height = 20.0
        var yVal = 0.0
        var width = 40.25
        var totalHeight : Double = Double(self.view.frame.size.height)
        var totalWidth : Double = Double(self.view.frame.size.width) - 40.0
        var navBarSize = 44.0
        
        if (self.navigationController != nil) {
            navBarSize = Double(self.navigationController!.navigationBar.frame.size.height)
            totalHeight -= navBarSize
        }
        
        var sizeOfHour = ((totalHeight - 10) / 12);
        var firstHour = navBarSize + sizeOfHour - 15;
        
        for hour in 8...17 {
            yVal = firstHour + (sizeOfHour * (Double(hour) - 7.0))
            
            var hourTextView = UITextView(frame: CGRect(x: xVal, y: yVal - 15, width: width, height: height));
            hourTextView.editable = false;
            
            var hourText = String(format: "%ld:00", hour)
            
            if (hour > 12) {
                hourText = String(format: "%ld:00", hour-12)
            }
            
            hourTextView.text = hourText
            subViews.append(hourTextView)
        }
        
        yVal = firstHour
        width = 40
        height = 20
        xVal = 50
        var count = 0
        
        for day in ["Mon", "Tues", "Wed", "Thur", "Fri"] {
            var dayTextView = UITextView(frame: CGRect(x: xVal + ((totalWidth - 10) / 5) * Double(count), y: yVal, width: width, height: height))
            dayTextView.text = day
            dayTextView.editable = false
            subViews.append(dayTextView)
            count++
        }
        
        
        return subViews;
    }
    
    private func createClassSubViews() -> [UIView] {
        var subViews : [UIView] = []
        var totalHeight = Int(self.view.frame.size.height)
        var navBarSize = 44
        
        if (self.navigationController != nil) {
            navBarSize = Int(self.navigationController!.navigationBar.frame.size.height)
            NSLog("Navbar: \(navBarSize)")
            totalHeight -= navBarSize;
        }
        
        var totalWidth : Int = Int(self.view.frame.size.width) - 45;
        var sizeOfHour = ((totalHeight - 10) / 12);
        var firstHour = navBarSize + sizeOfHour - 15;

        
        for cls in schedule.selectedClasses {
            var clsColor = getColorForClass(cls);
            
            if (cls.meetingTimes == nil) {
                continue;
            }
            
            for mtn in cls.meetingTimes! {
                if (mtn.type == MeetingTimeType.Class) {
                    
                    if (mtn.days == nil) {
                        continue;
                    }
                    
                    var startY = getYForTime(mtn.startTime!);
                    var endY = getYForTime(mtn.endTime!);
                    var mtnHeight = Int(Float(sizeOfHour) * (endY - startY))
                    
                    var yVal = firstHour + sizeOfHour * Int((startY - 7))

                    for day in mtn.days! {
                        let xVal = getXForDay(day);

                        var view : UIView = UIView(frame: CGRect(x: xVal, y: yVal, width: (totalWidth - 10)/5, height: mtnHeight));
                        
                        var gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleClassTap:");
                        
                        view.backgroundColor = clsColor;
                        view.layer.borderColor = UIColor.blackColor().CGColor;
                        view.layer.borderWidth = 2;
                        view.layer.cornerRadius = 10;
                        view.addGestureRecognizer(gestureRecognizer);
                        // view.tag = find(cls, schedule.selectedClasses)
                        
                        subViews.append(view);
                    }
                }
            }
        }
        
        return subViews;
    }
    
    func handleClassTap(recognizer: UITapGestureRecognizer) {
        NSLog("Class Tapped")
    }
    
    private func getXForDay(day : Day) -> Int {
        var totalWidth : Int = Int(self.view.frame.size.width);
        var factor = 1;
        
        if day == .Monday {
            factor = 0
        } else if day == .Wednesday {
            factor = 2;
        } else if day == .Thursday {
            factor = 3;
        } else if day == .Friday {
            factor = 4
        }
        
        return 40 + (((totalWidth - 10)/5) * factor);
    }
    
    private func getYForTime(date : NSDate) -> Float {
        let calendar = NSCalendar.currentCalendar()
        let comp = calendar.components((.CalendarUnitHour | .CalendarUnitMinute), fromDate: date)
        
        var hour = comp.hour;
        var min = comp.minute;
        
        if (hour < 7) {
            hour += 12;
        }
        
        return Float(hour) + Float(min)/Float(60);
    }
    
    private func getColorForClass(neuClass : NEUClass) -> UIColor {
        return UIColor.grayColor();
    }
    
}
