//
//  TimeCollectionViewCell.swift
//  TimeSwiper
//
//  Created by Stevie Parris on 2014-07-11.
//  Copyright (c) 2014 Stevie Parris All rights reserved.
//

import UIKit


class TimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var time: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        
    }
}
