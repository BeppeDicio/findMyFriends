//
//  Friend.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 28/09/2020.
//

import Foundation

class Friend {
    
    init(id: Int, name: String, lat: String, lng: String) {
        self.id = id
        self.name = name
        self.lat = lat
        self.lng = lng
    }
    
    var id: Int
    var name: String
    var email: String?
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var lat: String
    var lng: String
    var phone: String?
    var website: String?
    var companyName: String?
    var companyCatchPhrase: String?
    var companyBs: String?
}
