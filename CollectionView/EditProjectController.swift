//
//  EditProjectController.swift
//  CollectionView
//
//  Created by Stevie Parris on 2014-07-22.
//  Copyright (c) 2014 Michael Babiy. All rights reserved.
//

import UIKit

protocol ProjectControllerDelegate{
    func ProjContrFinished(controller:EditProjectController)
    
}

class EditProjectController: UIViewController {
 
    var delegate:ProjectControllerDelegate? = nil
    
    @IBOutlet var NameField: UITextField!
    
    @IBOutlet var DescriptionField: UITextView!
    
    var projects : NSMutableDictionary?
    
    var r = NSArray(array: [255, 255, 255, 178, 102, 102, 102, 102, 102, 178, 255, 255])
    var g = NSArray(array: [51, 178, 255, 255, 255, 255, 255, 178, 102, 102, 102, 153])
    var b = NSArray(array: [51, 102, 102, 102, 102, 178, 255, 255, 255, 255, 255, 204])
    
    var indexNumber : Int?
    
    var changed : Bool = false
    
    @IBAction func Cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion:nil);
    }
    
    @IBAction func Done(sender: AnyObject) {
        projects!.setObject(NameField.text, forKey: "Title")
        projects!.setObject(DescriptionField.text, forKey: "Description")
        
        if(projects!.objectForKey("Tasks") as? NSMutableDictionary != nil)
        {
            projects!.setObject(UIColor(red: r[indexNumber!] as CGFloat, green: g[indexNumber!] as CGFloat, blue: b[indexNumber!] as CGFloat, alpha: 1), forKey: "Color")
            projects!.setObject(NSMutableDictionary(), forKey: "Tasks")
        }
        changed = true
        
        
        self.delegate!.ProjContrFinished(self);
        //self.performSegueWithIdentifier("EditProject", sender: self)
        dismissViewControllerAnimated(true, completion:nil);
    }
}
