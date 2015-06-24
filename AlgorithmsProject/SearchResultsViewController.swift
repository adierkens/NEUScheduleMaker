//
//  SearchView.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/17/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class SearchResultsViewController: UICollectionViewController, SearchResultsHandler {
    
    private let cellReuseID = "SearchCell";
    private lazy var resultsList : [NEUClass] = [];
    
    @IBOutlet var searchResultsCollectionView: UICollectionView!
    lazy var data = NSMutableData();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("View did load");
        
        // Do any additional setup after loading the view, typically from a nib.
        
        searchResultsCollectionView.delegate = self;
        searchResultsCollectionView.dataSource = self;
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsList.count;
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseID, forIndexPath:
            indexPath) as! SearchResultCell;
        
        var neuClass = resultsList[indexPath.row];
        cell.setClass(neuClass)
        
        return cell;
    }
    
    func onNewData(neuClasses : [NEUClass]) {
        NSLog("Got new data");
        self.resultsList = neuClasses
        // Run the update on the main thread
        dispatch_async(dispatch_get_main_queue(), {
            self.searchResultsCollectionView.reloadData();
        });
    }
    
}
