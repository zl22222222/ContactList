//
//  ViewController.swift
//  ContactList
//
//  Created by Zhang Le on 15/5/6.
//  Copyright (c) 2015年 LeZhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var contactTableView: UITableView!
    let cellIdentifier = "ContactCell"
    
    var names:[ContactItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
        return names.count
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.performSegueWithIdentifier("ShowContactDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        
    {
        if let cell:UITableViewCell = contactTableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        {
            var name = names[indexPath.row].name
            let email = names[indexPath.row].email
            
            cell.textLabel!.text = name
            cell.detailTextLabel!.text = email
            return cell
        }
        else{
            let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
            
            var name = names[indexPath.row].name
            let email = names[indexPath.row].email
            
            cell.textLabel!.text = name
            cell.detailTextLabel!.text = email
            
            return cell
        }
        
    }
    
    @IBAction func sortButtonPressed(sender: UIBarButtonItem) {
        if sortButton.title == "Descend"{
            names = names.sorted { $0.trimmedName > $1.trimmedName }
            sortButton.title = "Ascend"
        }else{
            names = names.sorted { $0.trimmedName < $1.trimmedName }
            sortButton.title = "Descend"
        }
        contactTableView.reloadData()
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "ShowContactDetail"{
            if let destinationVC = segue.destinationViewController as? DetailViewController{
            }
        }
    }
}

