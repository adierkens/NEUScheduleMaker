//
//  ScheduleGeneratorViewController.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/22/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class ScheduleGeneratorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var dateSender : UIButton?
    var subjectStrings : [String]?
    var classIndexList : [NEUClassIndex]?
    
    static var dateFormatter = NSDateFormatter();
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var addClassView: UIView!
    @IBOutlet weak var classTableView: UITableView!
    @IBOutlet weak var timeAfterButton: UIButton!
    @IBOutlet weak var timeBeforeButton: UIButton!
    @IBOutlet weak var noClassAfterLabel: UILabel!
    @IBOutlet weak var noClassBeforeLabel: UILabel!
    @IBOutlet weak var noFridayClassLabel: UILabel!
    @IBOutlet weak var noClassAfterSwitch: UISwitch!
    @IBOutlet weak var noClassBeforeSwitch: UISwitch!
    @IBOutlet weak var noFridayClassSwitch: UISwitch!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var subjectPickerView: UIPickerView!
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var courseNumberTextField: UITextField!
    
    @IBOutlet weak var addClassButton: UIBarButtonItem!
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.subjectButton.setTitle("ALL", forState: UIControlState.Normal);
        self.courseNumberTextField.text = "";
        self.addClassView.hidden = true;
        self.classTableView.hidden = false;
        self.addClassButton.enabled = true;
    }
    
    @IBAction func addButtonPressed(sender: UIButton) {
        
        var subject = Subject(rawValue: subjectButton.titleLabel!.text!)
        var courseNum = courseNumberTextField.text.toInt();
        
        if (subject != nil && courseNum != nil) {
            classIndexList!.append(NEUClassIndex(subject: subject!, courseNumber: courseNum!))
            self.classTableView.reloadData()
            self.searchButton.enabled = true;
        }
        cancelButtonPressed(sender);
    }
    
    @IBAction func uiTextFieldEditingDidEnd(sender: UITextField) {
        sender.text = sender.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        var value : String?;
        if (sender.text == "") {
            value = nil;
        } else {
            value = sender.text;
        }
    }
    
    @IBAction func subjectButtonPressed(sender: UIButton) {
        self.subjectPickerView.hidden = false;
        self.timePicker.hidden = true;
    }
    
    @IBAction func addClassIndex(sender: UIBarButtonItem) {
        self.addClassView.hidden = false;
        self.classTableView.hidden = true;
        self.addClassButton.enabled = false;
    }
    
    @IBAction func dateChanged(sender: UIDatePicker) {
        let timeString = ScheduleGeneratorViewController.dateFormatter.stringFromDate(sender.date);
        if (dateSender == timeAfterButton) {
            timeAfterButton.setTitle(timeString, forState: UIControlState.Normal)
        } else if (dateSender == timeBeforeButton) {
            timeBeforeButton.setTitle(timeString, forState: UIControlState.Normal)
        }
    }
    
    @IBAction func tapPressed(sender: UITapGestureRecognizer) {
        self.timePicker!.hidden = true;
        self.subjectPickerView.hidden = true;
    }
    
    @IBAction func searchButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showResults", sender: self)
    }
    
    @IBAction func switched(sender: UISwitch) {
        self.timePicker.hidden = true;
        if (sender == noFridayClassSwitch) {
            self.noFridayClassLabel.enabled = sender.on
        } else if (sender == noClassAfterSwitch) {
            self.noClassAfterLabel.enabled = sender.on;
            self.timeAfterButton.enabled = sender.on;
        } else if (sender == noClassBeforeSwitch) {
            self.noClassBeforeLabel.enabled = sender.on;
            self.timeBeforeButton.enabled = sender.on;
        }
    }
    
    @IBAction func timePressed(sender: UIButton) {
        if !self.timePicker.hidden {
            self.timePicker.hidden = true;
            return;
        }
        
        self.dateSender = sender
        var date = getDateFromButton(sender);
        if (date != nil) {
            self.timePicker.date = date!
        }
        self.timePicker.hidden = false;
        self.subjectPickerView.hidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subjectStrings = []
        
        for s in iterateEnum(Subject) {
            self.subjectStrings!.append(s.rawValue);
        }
        // Do any additional setup after loading the view.
        self.classTableView!.delegate = self;
        self.classTableView!.dataSource = self;
        ScheduleGeneratorViewController.dateFormatter.dateFormat = "h:mm a"
        self.classIndexList = []
        
        self.subjectPickerView.dataSource = self;
        self.subjectPickerView.delegate = self;
        self.subjectPickerView.hidden = true;
        self.addClassView.hidden = true;
        self.searchButton.enabled = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("reuseCell") as! UITableViewCell;
        cell.textLabel!.text = classIndexList![indexPath.row].toString();
        return cell;
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classIndexList!.count;
    }
    
    func getDateFromButton(button : UIButton) -> NSDate? {
        let dateString = button.titleLabel!.text
        return ScheduleGeneratorViewController.dateFormatter.dateFromString(dateString!);
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        subjectButton.setTitle(self.subjectStrings![row], forState: UIControlState.Normal);
    }
    
    func numberOfComponentsInPickerView(_pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.subjectStrings!.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.subjectStrings![row];
    }
    
    func subjectAtIndex(index: Int) -> Subject? {
        
        if (index < 0 || index >= subjectStrings!.count) {
            return nil;
        }
        
        let str = subjectStrings![index];
        return Subject(rawValue: str)
    }
}
