//
//  ViewController.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/17/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UITextViewDelegate , UIPickerViewDataSource {
    var subjectStrings : [String]?
    @IBOutlet weak var seachButton: UIBarButtonItem!
    @IBOutlet var subjectPicker : UIPickerView!;
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var instructorTextField: UITextField!
    @IBOutlet weak var courseNumberTextField: UITextField!
    @IBOutlet weak var crnTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var scheduleButton: UIBarButtonItem!
    
    var neuSearchClass : NEUClass = NEUClass();
    
    @IBAction func buttonTouched(sender: UIButton) {
        NSLog("Button touched");
        subjectPicker.hidden = false;
    }
    
    @IBAction func uiTextFieldEditingDidEnd(sender: UITextField) {
        sender.text = sender.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        
        var value : String?;
        
        if (sender.text == "") {
            value = nil;
        } else {
            value = sender.text;
        }
        
        if (sender == instructorTextField) {
            neuSearchClass.instructor = value;
        } else if (sender == courseNumberTextField) {
            neuSearchClass.courseNumber = value?.toInt();
        } else if (sender == crnTextField) {
            neuSearchClass.crn = value?.toInt();
        } else if (sender == titleTextField) {
            neuSearchClass.title = value;
        }
    }
    
    @IBAction func tabGestureWasPressed(sender: UITapGestureRecognizer) {
        subjectPicker.hidden = true;
        instructorTextField.endEditing(true);
        courseNumberTextField.endEditing(true);
    }
    @IBAction func seachButtonWasPressed(sender: UIBarButtonItem) {
        NSLog("Search button was pressed");
        performSegueWithIdentifier("searchResults", sender: self);
    }
    

    @IBAction func scheduleButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showSchedule", sender: self);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subjectStrings = []
        
        for s in iterateEnum(Subject) {
            self.subjectStrings!.append(s.rawValue);
        }
        
        subjectPicker.hidden = true;
        subjectPicker.delegate = self;
        subjectPicker.dataSource = self;
        
        subjectPicker.showsSelectionIndicator = true;
        
        var toolbar = UIToolbar();
        toolbar.barStyle = UIBarStyle.Default;
        toolbar.translucent = true;
        toolbar.sizeToFit();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        subjectButton.setTitle(subjectStrings![row], forState: UIControlState.Normal);
        neuSearchClass.subject = Subject(rawValue: subjectStrings![row]);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "searchResults") {
            let viewController = segue.destinationViewController as! SearchResultsViewController;
            
            HttpDataHandler.startConnection(viewController, postData: neuSearchClass.toJsonString());
        }
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

