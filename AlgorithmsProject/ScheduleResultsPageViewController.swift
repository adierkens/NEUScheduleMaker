//
//  ScheduleResultsViewController.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/22/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class ScheduleResultsPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    private var currentPageIndex : Int?;
    private var allSchedules : [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPageIndex = 0;
        allSchedules = [1, 2, 3, 4]
        // Do any additional setup after loading the view.
        
        self.setViewControllers([viewControllerAtIndex(0)!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil);
        self.delegate = self
        self.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let pgController : ScheduleResultsViewController = viewController as! ScheduleResultsViewController;
        currentPageIndex = pgController.pageIndex! + 1
        return viewControllerAtIndex(currentPageIndex!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let pgController : ScheduleResultsViewController = viewController as! ScheduleResultsViewController;
        currentPageIndex = pgController.pageIndex! - 1
        return viewControllerAtIndex(currentPageIndex!)
    }

    func viewControllerAtIndex(index : Int) -> UIViewController? {
        
        if (index < 0 || index >= allSchedules!.count) {
            return nil;
        }
        
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("scheduleResultsViewController") as! ScheduleResultsViewController;
        pageContentViewController.pageIndex = index;
        pageContentViewController.pageCount = allSchedules!.count
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return allSchedules!.count;
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0;
    }
}
