//
//  Company.swift
//  MyEmployees
//
//  Created by escience on 8/24/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

class Company: NSObject, Codable {
    
    var id: Int?
    var name: String
    var username: String
    var password: String
    var contact: String
    var address: String
    var logoKey: String
    
    init(id: Int?=nil,
             name: String,
             username: String,
             password: String,
             contact: String,
             address: String,
             logoKey: String) {
        self.id = id
        self.name = name
        self.username = username
        self.password = password
        self.contact = contact
        self.address = address
        self.logoKey = logoKey
    }
    
    var dao: CompanyDao {
        CompanyDao(company: self)
    }
    
}
