//
//  DetailViewController.swift
//  ContactList
//
//  Created by Zhang Le on 15/5/7.
//  Copyright (c) 2015 LeZhang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var navbarTitle: UINavigationItem!
    @IBOutlet weak var detailTableView: UITableView!
    
    var contact:ContactItem = ContactItem()
    let cellIdentifier = "DetailTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting table cell to dynamic heights.
        detailTableView.estimatedRowHeight = 195
        detailTableView.rowHeight = UITableViewAutomaticDimension
        
        navbarTitle.title = contact.name
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        
    {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        
    {
        if let cell:DetailTableViewCell = detailTableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? DetailTableViewCell
        {
            populateCell(cell, row: indexPath.row)
            
            cell.contentLabel.numberOfLines = 0
            cell.contentLabel.preferredMaxLayoutWidth = cell.contentLabel.bounds.size.width;
            return cell
        }else{
            // Shouldn't execute this section unless an error occurred dequeuing reusable cell
            let cell:DetailTableViewCell = DetailTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            
            populateCell(cell, row: indexPath.row)
            
            return cell
        }
    }
    
    // Populate DetailTableViewCell based on the row number.
    func populateCell(cell: DetailTableViewCell, row: Int){
        switch row {
        case 0:
            cell.headerLabel.text = "Name"
            cell.contentLabel.text = contact.name
        case 1:
            cell.headerLabel.text = "Username"
            cell.contentLabel.text = contact.username
        case 2:
            cell.headerLabel.text = "Phone"
            cell.contentLabel.text = contact.phone
        case 3:
            cell.headerLabel.text = "Email"
            cell.contentLabel.text = contact.email
        case 4:
            cell.headerLabel.text = "Address"
            cell.contentLabel.text = contact.address.suite + " " +
                contact.address.street + "\n" +
                contact.address.city + ", " +
                contact.address.zipcode
        case 5:
            cell.headerLabel.text = "Website"
            cell.contentLabel.text = contact.website
        case 6:
            cell.headerLabel.text = "Company"
            cell.contentLabel.text = contact.company.name + "\n" +
                contact.company.catchPhrase + "\n" +
                contact.company.bs
        default:
            cell.headerLabel.text = "Error"
            cell.contentLabel.text = "Error"
        }
    }
}
