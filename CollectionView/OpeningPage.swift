//
//  ViewController.swift
//  Time Swiper v1
//
//  Created by Will Johannesen on 6/19/14.
//  Copyright (c) 2014 Will Johannesen. All rights reserved.
//
// Loads the welcome image
// Segues to next viewcontroller

import UIKit

class OpeningPage: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    
    //var event:UIEvent;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println( "And so it begins...")
        //var splash : UIImage = UIImage(named:"Time_Swiper_Image.jpg")
        
        //splash = UIImage(named: "Time_Swiper_Image")
        //imgView
        //var imageView = UIImageView(frame: CGRectMake(100, 150, 150, 150));

        
        //imgView.image = splash
        
        //self.view.addSubview(imgView)
        
        //let imgView2 = UIImageView(image: splash)
        //imgView.addSubview(imgView2)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}

