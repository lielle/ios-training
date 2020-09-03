//
//  Employee.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/3/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation
import SwiftyMenu

class Employee: NSObject, Codable {
    
    static let POSITIONS = [
        1: "CEO",
        2: "Project Manager",
        3: "Account Manager",
        4: "Tech Lead",
        5: "Developer",
        6: "QA",
    ]
    
    var id: Int?
    var companyId: Int?
    var name: String?
    var positionId: Int?
    var contact: String?
    var address: String?
    var logoKey: String?
    
    init(id: Int?=nil,
            companyId: Int,
            name: String,
            positionId: Int,
            contact: String?,
            address: String?,
            logoKey: String) {
        self.id = id
        self.companyId = companyId
        self.name = name
        self.positionId = positionId
        self.contact = contact
        self.address = address
        self.logoKey = logoKey
    }
    
}
