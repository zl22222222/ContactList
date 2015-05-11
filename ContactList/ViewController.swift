//
//  ViewController.swift
//  ContactList
//
//  Created by Zhang Le on 15/5/6.
//  Copyright (c) 2015 LeZhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var contactTableView: UITableView!
    
    let cellIdentifier = "ContactCell"
    
    var contacts:[ContactItem] = []
    var selectedItem: ContactItem = ContactItem()
    
    private var isAscend = true
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return contacts.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        selectedItem = contacts[indexPath.row]
        self.performSegueWithIdentifier("ShowContactDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if let cell:UITableViewCell = contactTableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        {
            populateCell(cell, row: indexPath.row)
            
            return cell
        }
        else{
            // Shouldn't execute this section unless an error occurred dequeuing reusable cell
            let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
            
            populateCell(cell, row: indexPath.row)
            
            return cell
        }
    }
    
    // Populate ContactCell with contact name and email address
    func populateCell(cell: UITableViewCell, row: Int){
        let name = self.contacts[row].name
        let email = self.contacts[row].email
        
        cell.textLabel!.text = name
        cell.detailTextLabel!.text = email
    }
    
    @IBAction func sortButtonPressed(sender: UIBarButtonItem) {
        if isAscend {
            contacts = contacts.sorted { $0.trimmedName > $1.trimmedName }
            sortButton.title = "Sort(↓)"
            isAscend = false
        } else {
            contacts = contacts.sorted { $0.trimmedName < $1.trimmedName }
            sortButton.title = "Sort(↑)"
            isAscend = true
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
