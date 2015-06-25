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
        
        return subViews;
    }
    
    private func createClassSubViews() -> [UIView] {
        var subViews : [UIView] = []
        var totalHeight = Int(self.view.frame.size.height)
        var navBarSize = 0
        
        if (self.navigationController != nil) {
            navBarSize = Int(self.navigationController!.navigationBar.frame.size.height)
            totalHeight -= navBarSize;
        }
        
        var totalWidth : Int = Int(self.view.frame.size.width);
        var sizeOfHour = ((totalHeight - 10) / 12);
        
        
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
                    
                    var yVal = navBarSize + sizeOfHour * Int((startY - 7))

                    
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
        NSLog("Class Tapped");
    }
    
    private func getXForDay(day : Day) -> Int {
        var totalWidth : Int = Int(self.view.frame.size.width);
        var factor = 1;
        
        if day == .Monday {
            return 10;
        } else if day == .Wednesday {
            factor = 2;
        } else if day == .Thursday {
            factor = 3;
        } else if day == .Friday {
            factor = 4
        }
        
        return ((totalWidth - 10)/5) * factor;
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
        return UIColor.blackColor();
    }
    
}
