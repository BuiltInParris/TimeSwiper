//
//  EditTaskController.swift
//  CollectionView
//
//  Created by Stevie Parris on 2014-07-22.
//  Copyright (c) 2014 Michael Babiy. All rights reserved.
//

import UIKit

class EditTaskController: UIViewController {

    @IBOutlet var NameField: UITextField!

    @IBOutlet var DescriptionField: UITextView!

    
    @IBAction func Cancel(sender: AnyObject) {
        //DON'T KEEP THE DATA
        dismissViewControllerAnimated(true, completion:nil);
    }
    
    @IBAction func Done(sender: AnyObject) {
        //KEEP THE DATA
        dismissViewControllerAnimated(true, completion:nil);
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!,
        sender: AnyObject!)
    {
    }
    
}
