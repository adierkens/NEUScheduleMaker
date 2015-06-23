//
//  ViewController.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/17/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    

    @IBOutlet weak var seachButton: UIBarButtonItem!
    @IBOutlet var subjectPicker : UIPickerView! = UIPickerView();
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var instructorTextField: UITextField!
    @IBOutlet weak var courseNumberTextField: UITextField!
    @IBOutlet weak var crnTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var scheduleButton: UIBarButtonItem!
    
    var subjectEnums : [String] = [];
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
        
        NSLog("TextView: \(value)");
        
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
        
        subjectPicker.hidden = true;
        subjectPicker.delegate = self;
        subjectPicker.dataSource = self;
        
        subjectPicker.showsSelectionIndicator = true;
        
        var toolbar = UIToolbar();
        toolbar.barStyle = UIBarStyle.Default;
        toolbar.translucent = true;
        toolbar.sizeToFit();
        
        
        for s in iterateEnum(Subject) {
            subjectEnums.append(s.rawValue);
        }

        subjectPicker.selectRow(0, inComponent: 0, animated: true);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(_pickerView: UIPickerView) -> Int {
        return 1;
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjectEnums.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return subjectEnums[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        subjectButton.setTitle(subjectEnums[row], forState: UIControlState.Normal);
        neuSearchClass.subject = Subject(rawValue: subjectEnums[row]);
    }
    
    
    func iterateEnum<T: Hashable>(_: T.Type) -> GeneratorOf<T> {
        var cast: (Int -> T)!
        switch sizeof(T) {
        case 0: return GeneratorOf(GeneratorOfOne(unsafeBitCast((), T.self)))
        case 1: cast = { unsafeBitCast(UInt8(truncatingBitPattern: $0), T.self) }
        case 2: cast = { unsafeBitCast(UInt16(truncatingBitPattern: $0), T.self) }
        case 4: cast = { unsafeBitCast(UInt32(truncatingBitPattern: $0), T.self) }
        case 8: cast = { unsafeBitCast(UInt64($0), T.self) }
        default: fatalError("cannot be here")
        }
        
        var i = 0
        return GeneratorOf {
            let next = cast(i)
            return next.hashValue == i++ ? next : nil
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "searchResults") {
            let viewController = segue.destinationViewController as! SearchResultsViewController;
            
            HttpDataHandler.startConnection(viewController, postData: neuSearchClass.toJsonString());
        }
    }
}

