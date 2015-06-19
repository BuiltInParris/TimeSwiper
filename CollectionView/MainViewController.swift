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

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate, ProjectControllerDelegate{
    
    @IBOutlet var leftcollectionview : UICollectionView!
    @IBOutlet var topcollectionview : UICollectionView!
    @IBOutlet var mainScrollView : UIScrollView!
    @IBOutlet var timecollectionview: UICollectionView!
    
    //Dictionary holding names of all projects and their associated tasks
    var projects: NSMutableArray = NSMutableArray()
    
    var tinicell:HomeCollectionViewCell?
    
    var tinicell2:TimeCollectionViewCell?
    
    var shrpr: UILongPressGestureRecognizer?
    
    var startButtonDraw:CGPoint?
    var endButtonDraw:CGPoint?
    
    
    var x1 : CGFloat?
    var x2 : CGFloat?
    var y : CGFloat?
    var cellLocation = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test if it can find userDefaults
        if let userDefaults = NSUserDefaults.standardUserDefaults()
        {
            //store the object in the userDefaults at key GameData location as a dictionary
            if(userDefaults.objectForKey("projects") as? NSMutableArray != nil)
            {
            projects = userDefaults.objectForKey("projects") as NSMutableArray
            //println(gameData) print the data in Dictionary
            }
            
            //REMOVES ALL DATA
            userDefaults.setObject(nil, forKey: "projects")
        }
        
        
        //store the images
        imagesLeft = ["Monday.png", "Tuesday.png", "Wednesday.png", "Thursday.png", "Friday.png", "Saturday.png", "Sunday.png"]
        
        
        var lpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        
        lpgr.minimumPressDuration = 2.0;
        
        topcollectionview.addGestureRecognizer(lpgr)
        
        
        shrpr = UILongPressGestureRecognizer(target: self, action: "ButtonTapped:")
        
        shrpr!.minimumPressDuration = 0.5;
        
        mainScrollView.addGestureRecognizer(shrpr!)
        
        
        
        //Set scrollview delegate (won't function without)
        mainScrollView.delegate = self;
        
    }
    
    func popoverControllerDidDismissPopover(popoverController: UIPopoverController) {
        println("User dismissed popover")
        //myPopover = nil
    }
    
    //Draws a button with specified style
    func drawButton(title:NSString, xloc:CGFloat, yloc:CGFloat, xendloc:CGFloat)
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
        if(xendloc > xloc)
        {
        myFirstButton.frame = CGRectMake(xloc, yloc, xendloc-xloc, tinicell!.frame.height)
        }
        else
        {
            myFirstButton.frame = CGRectMake(xendloc, yloc, abs(xendloc-xloc), tinicell!.frame.height)
        }
        myFirstButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        mainScrollView.addSubview(myFirstButton)
        mainScrollView.contentSize.height = cvleftheight
        mainScrollView.contentSize.width = topcollectionview.collectionViewLayout.collectionViewContentSize().width
        
    }
    
    //generic alert
    func pressed(sender: UIButton!) {
        var alert = UIAlertController(title: "Task Manager", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            println("DELETING")
            //self.dismissViewControllerAnimated(true, completion:{})
            //DELETE STUFF
            }))
        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            //SEGUE TO NEW PLACE
            //self.dismissViewControllerAnimated(true, completion:{})
            self.performSegueWithIdentifier("EditTask", sender: self)
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            //self.dismissViewControllerAnimated(true, completion:{})
            //DELETE STUFF
            }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //forces scrollview and the left collectionview to move in sync when called
    func matchScrollViewInY(firstguy:UIScrollView, secondguy:UIScrollView) {
    var offset = firstguy.contentOffset;
    offset.y = secondguy.contentOffset.y;
    firstguy.contentOffset = offset;
    }
    
    func matchScrollViewInX(firstguy:UIScrollView, secondguy:UIScrollView) {
        var offset = firstguy.contentOffset;
        offset.x = secondguy.contentOffset.x;
        firstguy.contentOffset = offset;
    }
    
    //Constant function called every time the scrollview moves and then uses the match function to make the two's locations equal.
    func scrollViewDidScroll(scrollView2: UIScrollView!) {
        if(scrollView2.isEqual(leftcollectionview)) {
            matchScrollViewInY(mainScrollView, secondguy: leftcollectionview)
        }
        if(scrollView2.isEqual(mainScrollView)) {
            matchScrollViewInY(leftcollectionview, secondguy: mainScrollView)
        }
        if(scrollView2.isEqual(timecollectionview)) {
            matchScrollViewInX(mainScrollView, secondguy: timecollectionview)
        }
        if(scrollView2.isEqual(mainScrollView)) {
            matchScrollViewInX(timecollectionview, secondguy: mainScrollView)
        }
        
    }
    
    func ButtonTapped(gestureRecognizer:UIGestureRecognizer) {
        if(gestureRecognizer.state == UIGestureRecognizerState.Began)
        {
            x1 = shrpr!.locationInView(mainScrollView).x
            y = shrpr!.locationInView(mainScrollView).y
            
            y = floor(y!/tinicell!.frame.height)*tinicell!.frame.height
        }
        else if(gestureRecognizer.state == UIGestureRecognizerState.Ended)
        {
            x2 = shrpr!.locationInView(mainScrollView).x
            
            drawButton("Task", xloc: x1!, yloc: y!, xendloc: x2!);
        }
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        var alert = UIAlertController(title: "Manage Project", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            println("DELETING")
            //self.dismissViewControllerAnimated(true, completion:{})
            //DELETE STUFF
            }))
        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            //SEGUE TO NEW PLACE
            //self.dismissViewControllerAnimated(true, completion:{})
            self.performSegueWithIdentifier("EditProject", sender: self)
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            //self.dismissViewControllerAnimated(true, completion:{})
            //DELETE STUFF
            }))
        self.presentViewController(alert, animated: true, completion: nil)
        //println("long press")
        
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
        else if(collectionView == topcollectionview)
        {
            imagesreturned = projects.count + 1
        }
        else if(collectionView == timecollectionview)
        {
            imagesreturned = 15
        }
        return imagesreturned
    }
    
    //Returns the images in the content of each cell.
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        if(collectionView == leftcollectionview)
        {
            tinicell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? HomeCollectionViewCell
            tinicell!.imageView.image = UIImage(named:imagesLeft[indexPath.row])
            
            return tinicell
        }
        else if(collectionView == topcollectionview)
        {
            tinicell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? HomeCollectionViewCell
            
            // TO BE REPLACED WITH PROJECTS INFO
            if(indexPath.row == projects.count)
            {
                tinicell!.backgroundColor = UIColor.whiteColor()
                tinicell!.title.text = "New Project"
            }
            else
            {
                tinicell!.title.text = projects.objectAtIndex(indexPath.row).objectForKey("Title") as String
                tinicell!.backgroundColor = projects.objectAtIndex(indexPath.row).objectForKey("Color") as? UIColor
            }
            
            return tinicell
        }
        
        else if(collectionView == timecollectionview)
        {
            tinicell2 = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? TimeCollectionViewCell
            if(indexPath.row + 6 <= 12)
            {
                tinicell2!.time.text = "\(indexPath.row + 6):00 AM"
            }
            else
            {
                tinicell2!.time.text = "\(indexPath.row - 5):00 PM"
            }
        }
        
        return tinicell2
    }
    
    //if item is selected in collectionview function
    func collectionView(collectionView: UICollectionView!,
        didSelectItemAtIndexPath indexPath: NSIndexPath!)
    {
        tinicell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? HomeCollectionViewCell
        
        cellLocation = indexPath.row
        
        if(collectionView == topcollectionview)
        {
            if(indexPath.row != projects.count)
            {
                self.performSegueWithIdentifier("TaskSegue", sender:self)
            }
            else
            {
                projects.addObject(NSMutableDictionary())
                self.performSegueWithIdentifier("EditProject", sender: self)
            }
        }
    }
    
    func ProjContrFinished(controller:EditProjectController)
    {
        if(controller.changed)
        {
            projects[cellLocation] = controller.projects!
            controller.changed = false
            println(projects)
        }
        else
        {
            println(projects)
            projects.removeObjectAtIndex(cellLocation)
        }
        self.topcollectionview.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!,
        sender: AnyObject!)
    {
        //SAVE DATA
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(projects, forKey: "projects")
        
        if(segue.identifier == "TaskSegue")
        {
            var controller : TasksViewController = segue.destinationViewController as TasksViewController
            controller.supercell = tinicell
            controller.popover_x = tinicell!.frame.origin.x - self.topcollectionview.contentOffset.x + tinicell!.title.frame.origin.x
        }
        else if(segue.identifier == "EditProject")
        {
            var controller : EditProjectController = segue.destinationViewController as EditProjectController
            controller.delegate = self;
            controller.projects = projects[cellLocation] as? NSMutableDictionary
            controller.indexNumber = cellLocation
        }
        
    }
}