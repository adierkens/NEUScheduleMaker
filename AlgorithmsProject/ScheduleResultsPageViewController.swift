//
//  ScheduleResultsViewController.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/22/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class ScheduleResultsPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, ScheduleResultsHandler {

    private var currentPageIndex : Int!;
    private var allSchedules : [Schedule]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPageIndex = 0;
        allSchedules = []
        
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("scheduleResultsViewController") as! ScheduleResultsViewController;
        
        self.setViewControllers([pageContentViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil);
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
    
    func onSchedulesFound(schedules : [Schedule]) {
        
    }
    
    func newScheduleFound(schedule : Schedule) {
        NSLog("Adding new schedule")
        allSchedules!.append(schedule);
        
        dispatch_async(dispatch_get_main_queue(), {
            self.dataSource = nil;
            self.dataSource = self;
            self.setViewControllers([self.viewControllerAtIndex(self.currentPageIndex)!], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil);
        });
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
        pageContentViewController.schedule = allSchedules[index];
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return allSchedules!.count;
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0;
    }
}
