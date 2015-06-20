//
//  ViewController.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/17/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate {
    
    @IBAction func tabGestureWasPressed(sender: UITapGestureRecognizer) {
        subjectPicker.hidden = true;
    }
    @IBOutlet weak var seachButton: UIBarButtonItem!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet var subjectPicker : UIPickerView! = UIPickerView();
    @IBOutlet weak var subjectButton: UIButton!
    @IBAction func buttonTouched(sender: UIButton) {
        NSLog("Button touched");
        subjectPicker.hidden = false;
    }
    
    @IBAction func seachButtonWasPressed(sender: UIBarButtonItem) {
        NSLog("Search button was pressed");
        performSegueWithIdentifier("searchResults", sender: self);
    }
    
    var subjectEnums : [String] = [];
    var neuSearchClass : NEUClass = NEUClass();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("View did load");
        
        // Do any additional setup after loading the view, typically from a nib.
        subjectLabel.text = "Subject";
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
        subjectLabel.text = subjectEnums[row];
        neuSearchClass.subject = Subject(rawValue: subjectLabel.text!);
        println(neuSearchClass.subject?.rawValue);
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

