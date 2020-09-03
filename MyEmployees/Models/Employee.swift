//
//  Employee.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/3/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

class Employee: NSObject, Codable {
    
    var id: Int?
    var companyId: Int?
    var name: String?
    var position: String?
    var contact: String?
    var address: String?
    var logoKey: String?
    
    init(id: Int?=nil,
            companyId: Int,
            name: String,
            position: String,
            contact: String?,
            address: String?,
            logoKey: String) {
        self.id = id
        self.companyId = companyId
        self.name = name
        self.position = position
        self.contact = contact
        self.address = address
        self.logoKey = logoKey
    }
    
}
