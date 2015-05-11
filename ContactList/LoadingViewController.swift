//
//  LoadingViewController.swift
//  ContactList
//
//  Created by Zhang Le on 15/5/7.
//  Copyright (c) 2015 LeZhang. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var contactItems:[ContactItem] = []
    var util:ViewControllerUtil = ViewControllerUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        util.showActivityIndicator(self.view)
    }
    
    // Reposition the activity indicator when the device is rotated
    func rotated()
    {
        util.hideActivityIndicator(self.view)
        util.showActivityIndicator(self.view)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/users")
        
        var data = NSData(contentsOfURL: url!)
        
        // Deserialize JSON and append the ContactItem object to array
        if let json: NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as? NSArray {
            for item in json {
                contactItems.append(ContactItem(json: item as! NSDictionary))
            }
        }
        
        self.util.hideActivityIndicator(self.view)
        self.performSegueWithIdentifier("FinishedLoading", sender: self)
        
        // Optional
        // A manual delay after JSON is acquired and deserialized before next view is loaded.
        // Sometimes the load screen is only displayed for a fraction of a second.
        //        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        //
        //        dispatch_after(delayTime, dispatch_get_main_queue()) {
        //            self.util.hideActivityIndicator(self.view)
        //            self.performSegueWithIdentifier("FinishedLoading", sender: self)
        //        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "FinishedLoading"{
            if let destinationVC = segue.destinationViewController as? UINavigationController{
                for vc in destinationVC.childViewControllers{
                    if let nextVC = destinationVC.childViewControllers[0] as? ViewController{
                        let sortedContacts = contactItems.sorted { $0.trimmedName < $1.trimmedName }
                        nextVC.contacts = sortedContacts
                    }
                }
            }
        }
    }
}
