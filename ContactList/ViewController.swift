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
    var selectedItem: ContactItem = ContactItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
        return names.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selectedItem = names[indexPath.row]
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
        if sortButton.title == "Sort(↑)"{
            names = names.sorted { $0.trimmedName > $1.trimmedName }
            sortButton.title = "Sort(↓)"
        }else{
            names = names.sorted { $0.trimmedName < $1.trimmedName }
            sortButton.title = "Sort(↑)"
        }
        contactTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "ShowContactDetail"{
            if let destinationVC = segue.destinationViewController as? DetailViewController{
                destinationVC.contact = selectedItem
            }
        }
    }
}
