//
//  LoadingViewController.swift
//  ContactList
//
//  Created by Zhang Le on 15/5/7.
//  Copyright (c) 2015年 LeZhang. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    var names:[ContactItem] = []
    var util:ViewControllerUtil = ViewControllerUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        util.showActivityIndicator(self.view)
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = NSURL(string: "http://jsonplaceholder.typicode.com/users")
        
        var data = NSData(contentsOfURL: url!)
        
        println(NSString(data: data!, encoding: NSUTF8StringEncoding))
        if let json: NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as? NSArray {
            for item in json {
                names.append(ContactItem(json: item as! NSDictionary))
                // construct your model objects here
            }
        }
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.util.hideActivityIndicator(self.view)
            self.performSegueWithIdentifier("FinishedLoading", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "FinishedLoading"{
            if let destinationVC = segue.destinationViewController as? UINavigationController{
                for vc in destinationVC.childViewControllers{
                    if let currentVC = destinationVC.childViewControllers[0] as? ViewController{
                        let sortedNames = names.sorted { $0.trimmedName < $1.trimmedName }
                        currentVC.names = sortedNames
                    }
                }
            }
        }
    }
}
