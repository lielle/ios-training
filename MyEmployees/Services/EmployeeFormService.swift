//
//  EmployeeFormService.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/7/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation
import UIKit

struct EmployeeFormService {
    
    var employee: Employee?
    var name: String?
    var positionId: Int?
    var contact: String?
    var address: String?
    var logo: UIImage
    
    init(employee: Employee?,
         name: String?,
         positionId: Int?,
         contact: String?,
         address: String?,
         logo: UIImage) {
        self.employee = employee
        self.name = name
        self.positionId = positionId
        self.contact = contact
        self.address = address
        self.logo = logo
    }
    
    // emptiness checking
    
    func isNameSupplied() -> Bool {
        let isEmpty = name?.isEmpty ?? true
        return !isEmpty
    }
    
    func isPositionSupplied() -> Bool {
        guard let positionId = positionId, positionId != 0 else {
            return false
        }
        return true
    }
    
    func addEmployee() {
        guard let employee = employee else {
            print("Unable to add employee. No employee object found.")
            return
        }
        
        employee.dao.insert()
        FileHelper.saveImage(logo, named: employee.logoKey)
    }
    
    func updateEmployee() {
        guard let employee = employee else {
            print("Unable to edit employee. No employee object found.")
            return
        }
        
        employee.dao.update()
        FileHelper.replaceImage(named: employee.logoKey, to: logo)
    }
    
}
