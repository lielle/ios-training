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
    
    static var DEFAULT_POSITIONS: [Int: String] {
        var positions: [Int:String] = [:]
        for position in EmployeePosition.DEFAULT_LIST {
            positions[position.id!] = position.description
        }
        return positions
    }
    
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
    
    var dao: EmployeeDao {
        EmployeeDao(employee: self)
    }
    
}
