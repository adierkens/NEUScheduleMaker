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
    
    @IBOutlet weak var pageNumLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if (pageIndex != nil) {
            pageNumLabel.text = String(pageIndex!);
            pageControl.numberOfPages = 5;
            pageControl.currentPage = pageIndex!;
        }
    }
    
    func setPageNum(pg : Int) {
        pageIndex = pg;
    }
    
}
