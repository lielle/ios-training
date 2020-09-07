//
//  CompanyRegistrationService.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/7/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation
import UIKit

struct CompanyRegistrationService {
    
    var name: String?
    var username: String?
    var password: String?
    var contact: String?
    var address: String?
    var logo: UIImage
    
    init(name: String?,
         username: String?,
         password: String?,
         contact: String?,
         address: String?,
         logo: UIImage) {
        self.name = name
        self.username = username
        self.password = password
        self.contact = contact
        self.address = address
        self.logo = logo
    }
    
    var hashedPassword: String {
        password?.sha256(salt: PASSWORD_SALT).hexString ?? ""
    }
    
    // emptiness checking
    
    func isNameSupplied() -> Bool {
        let isEmpty = name?.isEmpty ?? true
        return !isEmpty
    }
    
    func isUsernameSupplied() -> Bool {
        let isEmpty = username?.isEmpty ?? true
        return !isEmpty
    }
    
    func isPasswordSupplied() -> Bool {
        let isEmpty = password?.isEmpty ?? true
        return !isEmpty
    }
    
    // duplicate checking
    
    func isUsernameUnique() -> Bool {
        guard let username = username, let _ = CompanyDao.fetchCompanyBy(username: username) else {
            return true
        }
        return false
    }
    
    // password validity
    
    func isPasswordSecured() -> Bool {
        guard let password = password else {
            return false
        }
        
        // at least 1 uppercase, 1 lowercase and 1 number
        let range = NSRange(location: 0, length: password.utf16.count)
        let patterns = [".*[a-z]+.*", ".*[A-Z]+.*", ".*[0-9]+.*"]
        for pattern in patterns {
            let regex = try! NSRegularExpression(pattern: pattern)
            guard regex.firstMatch(in: password, options: [], range: range) != nil else {
                return false
            }
        }
        return true
    }
    
    func addCompany() throws {
        guard let name = name, let username = username, let contact = contact, let address = address else {
            throw OptionalsError.incomplete
        }
        
        let company = Company(name: name, username: username, password: hashedPassword, contact: contact, address: address, logoKey: UUID().uuidString)
        
        company.dao.insert()
        FileHelper.saveImage(logo, named: company.logoKey)
    }
    
}
