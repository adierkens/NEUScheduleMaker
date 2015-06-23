//
//  HttpDataHandler.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/20/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import Foundation

class HttpDataHandler {
    
     class func startConnection(delagate : SearchResultsViewController, postData : String) {
        let urlPath : String = "http://adamdierkens.com:9999"
        var url : NSURL = NSURL(string: urlPath)!;
        
        println("POST: \(postData)");
        
        let request : NSMutableURLRequest = NSMutableURLRequest(URL: url);
        request.HTTPMethod = "POST";
        request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                println("error=\(error)");
                return;
            }
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding);
            NSLog("ResponseString: \(responseString)");
            var arrayOfDicts : NSMutableArray? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSMutableArray;
            if (arrayOfDicts != nil) {
                delagate.onNewData(arrayOfDicts!);
            }
            
        }
        task.resume();
        
    }
    
}