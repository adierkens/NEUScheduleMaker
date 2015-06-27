//
//  SearchResultCell.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/20/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    var neuClass : NEUClass!;
    static var dateFormatter = NSDateFormatter();

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var crnLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        ScheduleGeneratorViewController.dateFormatter.dateFormat = "h:mm a"
    }

    func setClass(neuClass : NEUClass) {
        if (neuClass.title != nil) {
            titleLabel.text = neuClass.title!;
        }
        if (neuClass.crn != nil) {
            crnLabel.text = String(stringInterpolationSegment: neuClass.crn!)
        }
        if (neuClass.instructor != nil) {
            instructorLabel.text = neuClass.instructor!
        }
        
        var dayString = "";
        var timeString = "";
        
        
        
        if neuClass.meetingTimes != nil {
            for mt in neuClass.meetingTimes! {
                
                if mt.type == MeetingTimeType.Class {
                
                var mtDayRow = "";
                var mtTimeRow = "";
                var mtPrefix = "";
                
                if mt.days != nil {
                    var prefix = ""
                    for d in mt.days! {
                        mtDayRow += prefix + d.toString();
                        prefix = ","
                    }
                }
                
                mtTimeRow = dateStringFromTime(mt.startTime) + "-" + dateStringFromTime(mt.endTime)
                
                dayString += mtPrefix + mtDayRow
                timeString += mtPrefix + mtTimeRow
                mtPrefix = "\n"
                }
                
            }
        }
        
        daysLabel.text = dayString;
        timeLabel.text = timeString;
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    func dateStringFromTime(date : NSDate?) -> String {
        
        if date == nil {
            return "N/A"
        }
        
        let calendar = NSCalendar.currentCalendar()
        
        
        let comp = calendar.components((.CalendarUnitHour | .CalendarUnitMinute), fromDate: date!)
        
        var ap = "am"
        var hour = comp.hour;
        var min = comp.minute;
        
        if (hour == 12) {
            ap = "pm"
        }
        if (hour > 12) {
            ap = "pm"
            hour -= 12
        }
        
        return String(hour) + ":" + String(min) + " " + ap
        
    }
}
