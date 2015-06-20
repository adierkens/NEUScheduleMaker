//
//  SearchResultCell.swift
//  AlgorithmsProject
//
//  Created by Adam Dierkens on 6/20/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    var textLabel : UILabel!;
    var imageView : UIImageView!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height);
        textLabel = UILabel(frame: textFrame);
        textLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize());
        textLabel.textAlignment = .Center;
        contentView.addSubview(textLabel);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
