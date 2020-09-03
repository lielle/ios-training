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
    
    var id: Int
    var description: String
    
    static func array(of positions: [Int: String]) -> [EmployeePosition] {
        var employeePositions: [EmployeePosition] = []
        for position in positions {
            employeePositions.append(EmployeePosition(id: position.key, description: position.value))
        }
        return employeePositions
    }
    
    public var retrievableValue: Any {
        self.id
    }
    
    public var displayableValue: String {
        self.description
    }
    
}
