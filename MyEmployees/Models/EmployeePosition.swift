//
//  EmployeePosition.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/3/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation
import SwiftyMenu

struct EmployeePosition: SwiftyMenuDisplayable {
    
    static let DEFAULT_LIST = [
        EmployeePosition(id: 1, description: Label.CEO),
        EmployeePosition(id: 2, description: Label.PROJECT_MANAGER),
        EmployeePosition(id: 3, description: Label.ACCOUNT_MANAGER),
        EmployeePosition(id: 4, description: Label.TECH_LEAD),
        EmployeePosition(id: 5, description: Label.DEVELOPER),
        EmployeePosition(id: 6, description: Label.QA),
    ]
    
    static var DEFAULT_WITH_ALL_OPTION: [EmployeePosition] {
        let allOption = [EmployeePosition(id: 0, description: Label.ALL_POSITIONS)]
        return allOption + DEFAULT_LIST
    }
    
    var id: Int?
    var description: String
    
    public var retrievableValue: Any {
        self.id as Any
    }
    
    public var displayableValue: String {
        self.description
    }
    
}
