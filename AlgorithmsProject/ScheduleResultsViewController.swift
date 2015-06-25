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
    var schedule : Schedule?
    
    @IBOutlet weak var pageNumLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if (pageIndex != nil) {
            pageNumLabel.text = String(pageIndex!);
            pageControl.numberOfPages = pageCount!;
            pageControl.currentPage = pageIndex!;
        }
        
        if self.schedule != nil {
            loadScheduleView()
        }
    }
    
    func loadScheduleView() {
        
        if self.schedule == nil {
            return;
        }
        
        
        
        
    }
    
}
