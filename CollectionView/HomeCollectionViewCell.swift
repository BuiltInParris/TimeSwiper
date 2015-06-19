//
//  HomeCollectionViewCell.swift
//  TimeSwiper
//
//  Created by Stevie Parris on 2014-07-11.
//  Copyright (c) 2014 Stevie Parris All rights reserved.
//

import UIKit


class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var title: UILabel!
    
   override  init(frame: CGRect) {
        super.init(frame: frame)
        var layer = self.layer
        layer.cornerRadius = 6
        layer.rasterizationScale = UIScreen.mainScreen().scale
        layer.shouldRasterize = true
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 2
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        var layer = self.layer
        layer.cornerRadius = 25
        layer.rasterizationScale = UIScreen.mainScreen().scale
        layer.shouldRasterize = true
        layer.borderColor = UIColor.lightTextColor().CGColor
        layer.borderWidth = 2
        //layer.backgroundColor = UIColor(0, 0, 0, 0).CGColor
        
        //UIColor(red: CGFloat(r[0] as NSNumber), green: CGFloat(g[0] as NSNumber), blue: CGFloat(b[0] as NSNumber), alpha: 1)
        //layer.backgroundColor =  UIColor(mr/255, mg/255, mb/255, 1).CGColor
        
    // colorArray[1][1]
        
    }
    
    //func popOverClick(button: UIButton){
     //   var delegate:MainViewController!
     //   delegate.didPopOverClickInCell(self);
   // }
}
