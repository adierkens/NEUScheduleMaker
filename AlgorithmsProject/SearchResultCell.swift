//
//  SearchResultCell.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/20/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    var neuClass : NEUClass!;
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var crnLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }

    func setClass(neuClass : NEUClass) {
        if (neuClass.title != nil) {
            NSLog(neuClass.title!);
            titleLabel.text = neuClass.title!;
        }
        if (neuClass.crn != nil) {
            crnLabel.text = String(stringInterpolationSegment: neuClass.crn!)
        }
        if (neuClass.instructor != nil) {
            instructorLabel.text = neuClass.instructor!
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
}
