//
//  ViewController.swift
//  TimeSwiper
//
//  Created by Stevie Parris on 2014-07-11.
//  Copyright (c) 2014 Stevie Parris All rights reserved.
//

import UIKit

var imagesLeft = [String]()
var imagesTop = [String]()

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate{
    
    @IBOutlet var leftcollectionview : UICollectionView
    @IBOutlet var topcollectionview : UICollectionView
    @IBOutlet var mainScrollView : UIScrollView
    
    var hiWill : NSNumber?
    
    
    //Dictionary holding names of all projects and their associated tasks
    var projects: NSDictionary = NSDictionary()
    
    var tinicell:HomeCollectionViewCell?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test if it can find userDefaults
        if let userDefaults = NSUserDefaults.standardUserDefaults()
        {
            //store the object in the userDefaults at key GameData location as a dictionary
            if(userDefaults.objectForKey("projects") as? NSDictionary != nil)
            {
            projects = userDefaults.objectForKey("projects") as NSDictionary
            //println(gameData) print the data in Dictionary
            }
        }
        
        //store the images
        imagesLeft = ["Monday.png", "Tuesday.png", "Wednesday.png", "Thursday.png", "Friday.png", "Saturday.png", "Sunday.png"]
        imagesTop = ["Monday.png", "Monday.png", "Monday.png", "Monday.png", "Monday.png", "Monday.png", "Monday.png", "Monday.png", "Monday.png", "Monday.png"]
        
        //Set scrollview delegate (won't function without)
        mainScrollView.delegate = self;
        
        //Call draw button function
        drawButton("hey, how are you doing sirrah?", xloc: 0, yloc: 0);
        
        
    }
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        println("User dismissed popover")
        //myPopover = nil
    }
    
    //Draws a button with specified style
    func drawButton(title:NSString, xloc:CGFloat, yloc:CGFloat)
    {
        var cvleftheight = leftcollectionview.collectionViewLayout.collectionViewContentSize().height
        var cvleftwidth = leftcollectionview.collectionViewLayout.collectionViewContentSize().width
        
        let myFirstButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        var btnLayer = myFirstButton.layer
        btnLayer.masksToBounds = true
        btnLayer.cornerRadius = 5.0
        btnLayer.borderWidth = 2.0
        btnLayer.borderColor = UIColor.grayColor().CGColor
        myFirstButton.setTitle(title, forState: .Normal)
        myFirstButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        myFirstButton.backgroundColor = UIColor.blueColor()
        
        
        //x and y coords detemined by first touch, width of button should be based on user second touch
        
        myFirstButton.frame = CGRectMake(xloc, yloc, CGFloat(title.length)*12, cvleftwidth)
        myFirstButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        mainScrollView.addSubview(myFirstButton)
        //mainScrollView.contentSize.height = cvleftheight
        mainScrollView.contentSize.width = 1000
    }
    
    //generic alert
    func pressed(sender: UIButton!) {
        var alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = "title";
        alertView.message = "message";
        alertView.show();
    }
    
    //forces scrollview and the left collectionview to move in sync when called
    func matchScrollView(firstguy:UIScrollView, secondguy:UIScrollView) {
    var offset = firstguy.contentOffset;
    offset.y = secondguy.contentOffset.y;
    firstguy.contentOffset = offset;
    }
    
    //Constant function called every time the scrollview moves and then uses the match function to make the two's locations equal.
    func scrollViewDidScroll(scrollView2: UIScrollView!) {
        if(scrollView2.isEqual(leftcollectionview)) {
            matchScrollView(mainScrollView, secondguy: leftcollectionview)
        }
        if(scrollView2.isEqual(mainScrollView)) {
            matchScrollView(leftcollectionview, secondguy: mainScrollView)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //Returns the number of images in the collection view
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        var imagesreturned = 0;
        if(collectionView == leftcollectionview)
        {
            imagesreturned = imagesLeft.count
        }
        if(collectionView == topcollectionview)
        {
            imagesreturned = imagesTop.count
        }
        return imagesreturned
    }
    
    
    //Returns the images in the content of each cell.
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        tinicell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? HomeCollectionViewCell
        if(collectionView == leftcollectionview)
        {
            tinicell!.imageView.image = UIImage(named:imagesLeft[indexPath.row])
        }
        if(collectionView == topcollectionview)
        {
            
            tinicell!.title.text = "fabulous"
        }
        
        return tinicell
    }
    
    //if item is selected in collectionview function
    func collectionView(collectionView: UICollectionView!,
        didSelectItemAtIndexPath indexPath: NSIndexPath!)
    {
        tinicell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? HomeCollectionViewCell
        
        if(collectionView == topcollectionview)
        {
            self.performSegueWithIdentifier("ProjectSegue", sender:self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!,
        sender: AnyObject!)
    {
        //SAVE DATA
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(projects, forKey: "projects")
        
        if(segue.identifier == "ProjectSegue")
        {
            var controller : TasksViewController = segue.destinationViewController as TasksViewController
            controller.supercell = tinicell
            controller.popover_x = tinicell!.frame.origin.x - self.topcollectionview.contentOffset.x + tinicell!.title.frame.origin.x
        }
    }
}