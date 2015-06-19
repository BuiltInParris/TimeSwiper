//
//  ProjectsViewController.swift
//  TimeSwiper
//
//  Created by Stevie Parris on 2014-07-11.
//  Copyright (c) 2014 Stevie Parris All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate
{


    var tasks: NSDictionary = NSDictionary()
    //Dictionary holding names of all projects and their associated tasks
    var taskNames: NSMutableArray = NSMutableArray()
    var taskDays: NSMutableArray = NSMutableArray()
    var taskStartTime: NSMutableArray = NSMutableArray()
    var taskEndTime: NSMutableArray = NSMutableArray()
    
    var supercell: HomeCollectionViewCell?
    var popover_x: CGFloat?
    
    //Tableview object
    @IBOutlet var tableView: UITableView!
    
    //method that calls when the page loads
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // popover settings
        modalPresentationStyle = .Popover
        self.popoverPresentationController.sourceView = self.view
        self.popoverPresentationController.sourceRect = CGRectMake(-370 + popover_x!, 0, 190, 250)

        
        var shrpr = UILongPressGestureRecognizer(target: self, action: "ButtonTapped:")
        
        shrpr.minimumPressDuration = 0.5;
        
        tableView.addGestureRecognizer(shrpr)
        
        
        //Register the tableview and cell type
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //test if it can find userDefaults
        if let userDefaults = NSUserDefaults.standardUserDefaults()
        {
            //store the object in the userDefaults at key GameData location as a dictionary
            //gameData = userDefaults.objectForKey("GameData") as Dictionary
            //println(gameData) print the data in Dictionary
        }
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        //cancel button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "tapCancel:")
        
        // popover settings
        modalPresentationStyle = .Popover
        popoverPresentationController.delegate = self
        popoverPresentationController.sourceView = nil
        
        
        
        
        self.preferredContentSize = CGSize(width:190,height:250)
    }
    
    func tapCancel(_ : UIBarButtonItem) {
        //tap cancel
        dismissViewControllerAnimated(true, completion:nil);
    }


//how to update Dictionary item
//gameData.updateValue("newvalue2", forKey: "newfield2")

//How to save the file
    //let userDefaults = NSUserDefaults.standardUserDefaults()
    //userDefaults.setObject(gameData, forKey: "GameData")
    
    //Dismissing view controller
    //self.dismissViewControllerAnimated(true, completion:{})
    
    //Method used to find the number of rows in a section, return an integer with number
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    //returns the cell with any content you want to put inside it.
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        //This is how you set the text in the tableview cells
        //cell.textLabel.text = self.projects.objectForKey("field")[indexPath.row]
        cell.textLabel.text = "row \(indexPath.row)"
        
        return cell
    }
    
    //Method that takes place when you select a row.
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        //DO STUFF
        // change title to the name of the task
        var alert = UIAlertController(title: "Task Name", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            println("DELETING")
            self.dismissViewControllerAnimated(true, completion:{})
            //self.dismissViewControllerAnimated(true, completion:{})
            //DELETE STUFF
            }))
        alert.addAction(UIAlertAction(title: "Edit", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            //SEGUE TO NEW PLACE
            //self.dismissViewControllerAnimated(true, completion:{})
            self.performSegueWithIdentifier("TaskEdit", sender: self)
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!)in
            self.dismissViewControllerAnimated(true, completion:{})
            //self.dismissViewControllerAnimated(true, completion:{})
            //DELETE STUFF
            }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue!,
        sender: AnyObject!)
    {
        self.dismissViewControllerAnimated(true, completion:{})
    }
    
    
    // popover settings, adaptive for horizontal compact trait
    // #pragma mark - UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyleForPresentationController(PC: UIPresentationController!) -> UIModalPresentationStyle{
        
        return .None
        
    }
    
    func presentationController(_: UIPresentationController!, viewControllerForAdaptivePresentationStyle _: UIModalPresentationStyle)
        -> UIViewController!{
            return UINavigationController(rootViewController: self)
    }
}



