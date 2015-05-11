//
//  contactItem.swift
//  ContactList
//
//  Created by Zhang Le on 15/5/6.
//  Copyright (c) 2015 LeZhang. All rights reserved.
//
//  This file defines the class of objects returned in the HTTP request.
//  JSON return is converted to objects.

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
    // Trim the name of any common title
    var trimmedName: String{
        set{
            // Name is too short to have title
            if count(newValue) < 4{
                _trimmedName = newValue
            }else{
                // If name has a title, remove it for sorting
                let initial = (newValue.lowercaseString as NSString).substringWithRange(NSRange(location: 0, length: 4))
                if  initial == "mr. "{
                    _trimmedName = newValue.substringWithRange(Range<String.Index>(start: advance(newValue.startIndex, 4), end: newValue.endIndex))
                }else if  initial == "ms. "{
                    _trimmedName = newValue.substringWithRange(Range<String.Index>(start: advance(newValue.startIndex, 4), end: newValue.endIndex))
                }else if initial == "mrs."{
                    _trimmedName = newValue.substringWithRange(Range<String.Index>(start: advance(newValue.startIndex, 5), end: newValue.endIndex))
                }else if initial == "miss"{
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
    
    init(json: NSDictionary) {
        self._trimmedName = ""
        
        if let id = json["id"] as? Int{
            self.id = id
        }else{
            self.id = 0
        }
        
        if let name = json["name"] as? String{
            self.name = name
        }else{
            self.name = ""
        }
        
        if let username = json["username"] as? String{
            self.username = username
        }else{
            self.username = ""
        }
        
        if let email = json["email"] as? String{
            self.email = email
        }else{
            self.email = ""
        }
        
        if let address = json["address"] as? NSDictionary{
            self.address = AddressItem(json: address)
        }else{
            self.address = AddressItem()
        }
        
        if let phone = json["phone"] as? String{
            self.phone = phone
        }else{
            self.phone = ""
        }
        
        if let website = json["website"] as? String{
            self.website = website
        }else{
            self.website = ""
        }
        
        if let company = json["company"] as? NSDictionary{
            self.company = CompanyItem(json: company)
        }else{
            self.company = CompanyItem()
        }
        self.trimmedName = self.name
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
        if let street = json["street"] as? String{
            self.street = street
        }else{
            self.street = ""
        }
        
        if let suite = json["suite"] as? String{
            self.suite = suite
        }else{
            self.suite = ""
        }
        
        if let city = json["city"] as? String{
            self.city = city
        }else{
            self.city = ""
        }
        
        if let zipcode = json["zipcode"] as? String{
            self.zipcode = zipcode
        }else{
            self.zipcode = ""
        }
        
        if let geo = json["geo"] as? NSDictionary{
            self.geo = GeoItem(json: geo)
        }else{
            self.geo = GeoItem()
        }
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
        if let name = json["name"] as? String{
            self.name = name
        }else{
            self.name = ""
        }
        
        if let catchPhrase = json["catchPhrase"] as? String{
            self.catchPhrase = catchPhrase
        }else{
            self.catchPhrase = ""
        }
        
        if let bs = json["bs"] as? String{
            self.bs = bs
        }else{
            self.bs = ""
        }
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
        if let lat = json["lat"] as? String{
            self.lat = lat
        }else{
            self.lat = ""
        }
        
        if let lng = json["lng"] as? String{
            self.lng = lng
        }else{
            self.lng = ""
        }
    }
}
