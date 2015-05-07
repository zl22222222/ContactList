//
//  contactItem.swift
//  ContactList
//
//  Created by Zhang Le on 15/5/6.
//  Copyright (c) 2015年 LeZhang. All rights reserved.
//

import UIKit

class ContactItem {
    
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: AddressItem
    var phone: String
    var website: String
    var company: CompanyItem
    
    private var _trimmedName: String;
    var trimmedName: String{
        set{
            if count(newValue) < 4{
                _trimmedName = newValue
            }else{
                let initial = (newValue.lowercaseString as NSString).substringWithRange(NSRange(location: 0, length: 4))
                if  initial == "mr. "{
                    _trimmedName = newValue.substringWithRange(Range<String.Index>(start: advance(newValue.startIndex, 4), end: newValue.endIndex))
                }else if initial == "mrs."{
                    _trimmedName = newValue.substringWithRange(Range<String.Index>(start: advance(newValue.startIndex, 5), end: newValue.endIndex))
                }else{
                    _trimmedName = newValue
                }
            }
        }
        get{
            return _trimmedName;
        }
    }
    
    init(json: NSDictionary) {
        self._trimmedName = ""
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        self.username = json["username"] as! String
        self.email = json["email"] as! String
        self.address = AddressItem(json: json["address"] as! NSDictionary)
        self.phone = json["phone"] as! String
        self.website = json["website"] as! String
        self.company = CompanyItem(json: json["company"] as! NSDictionary)
        self.trimmedName = json["name"] as! String
    }
    
    init(){
        self._trimmedName = ""
        self.id = 0
        self.name = ""
        self.username = ""
        self.email = ""
        self.address = AddressItem()
        self.phone = ""
        self.website = ""
        self.company = CompanyItem()
        self.trimmedName = ""
    }
}

class AddressItem{
    
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: GeoItem
    
    init() {
        self.street = ""
        self.suite = ""
        self.city = ""
        self.zipcode = ""
        self.geo = GeoItem()
    }
    
    init(json: NSDictionary) {
        self.street = json["street"] as! String
        self.suite = json["suite"] as! String
        self.city = json["city"] as! String
        self.zipcode = json["zipcode"] as! String
        self.geo = GeoItem(json: json["geo"] as! NSDictionary)
    }
}

class CompanyItem {
    
    var name: String
    var catchPhrase: String
    var bs: String
    
    init() {
        self.name = ""
        self.catchPhrase = ""
        self.bs = ""
    }
    
    init(json: NSDictionary) {
        self.name = json["name"] as! String
        self.catchPhrase = json["catchPhrase"] as! String
        self.bs = json["bs"] as! String
    }
}

class GeoItem {
    
    var lat: String
    var lng: String
    
    init() {
        self.lat = ""
        self.lng = ""
    }
    
    init(json: NSDictionary) {
        self.lat = json["lat"] as! String
        self.lng = json["lng"] as! String
    }
}
