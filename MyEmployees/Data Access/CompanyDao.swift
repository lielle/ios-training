//
//  CompanyDao.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/3/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

class CompanyDao {
    
    static func insert(company: Company) {
        let query = "INSERT INTO company(name, username, password, contact, address, logo) VALUES (?, ?, ?, ?, ?, ?);"
        let params = [
            company.name!,
            company.username!,
            company.password!,
            company.contact!,
            company.address!,
            company.logoKey!,
            
        ]
        DatabaseHelper.shared.insert(query: query, params: params)
    }
    
}
