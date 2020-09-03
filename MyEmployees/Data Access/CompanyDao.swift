//
//  CompanyDao.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/3/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

class CompanyDao {
    
    static func setLoggedIn(company: Company) {
        UserDefaults.standard.set(encodable: company, forKey: "company")
    }
    
    static func getLoggedIn() -> Company? {
        let company = UserDefaults.standard.value(Company.self, forKey: "company")
        return company
    }
    
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
    
    static func fetchCompanyPasswordBy(username: String) -> String? {
        let query = "SELECT password FROM company WHERE username=?;"
        let columnTypes = [String.self]
        let params = [username]
        
        guard let response = DatabaseHelper.shared.fetch(query: query, columnTypes: columnTypes, params: params) else {
            return nil
        }
        
        return response[0][0] as? String
    }
    
    static func fetchCompanyBy(username: String) -> Company? {
        let query = "SELECT id, name, username, password, contact, address, logo FROM company WHERE username=?;"
        let columnTypes: [Any.Type] = [Int.self, String.self, String.self, String.self, String.self, String.self, String.self]
        let params = [username]
        
        guard let response = DatabaseHelper.shared.fetch(query: query, columnTypes: columnTypes, params: params) else {
            return nil
        }
        
        let companyFields = response[0]
        let id = companyFields[0] as! Int
        let name = companyFields[1] as! String
        let username = companyFields[2] as! String
        let password = companyFields[3] as! String
        let contact = companyFields[4] as! String
        let address = companyFields[5] as! String
        let logoKey = companyFields[6] as! String
        let company = Company(id: id, name: name, username: username, password: password, contact: contact, address: address, logoKey: logoKey)
        return company
    }
    
}
