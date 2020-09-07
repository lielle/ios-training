//
//  CompanyUpdateService.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/7/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation
import UIKit

struct CompanyUpdateService {
    
    var company: Company
    var username: String?
    var contact: String?
    var address: String?
    var logo: UIImage
    
    init(company: Company,
         username: String?,
         contact: String?,
         address: String?,
         logo: UIImage) {
        self.company = company
        self.username = username
        self.contact = contact
        self.address = address
        self.logo = logo
    }
    
    // emptiness checking
    
    func isUsernameSupplied() -> Bool {
        let isEmpty = username?.isEmpty ?? true
        return !isEmpty
    }
    
    // duplicate checking
    
    func isUsernameUnique() -> Bool {
        guard let username = username, username != company.username, let _ = CompanyDao.fetchCompanyBy(username: username) else {
            return true
        }
        return false
    }

    func update() throws {
        guard let username = username, let contact = contact, let address = address else {
            print("Company could not be updated")
            throw OptionalsError.incomplete
        }
        
        company.username = username
        company.contact = contact
        company.address = address
        
        FileHelper.replaceImage(named: company.logoKey, to: logo)
        company.dao.setAsLoggedIn()
        company.dao.update()
    }
    
}
