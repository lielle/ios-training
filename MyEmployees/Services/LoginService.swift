//
//  LoginService.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/7/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

struct LoginService {
    
    var username: String?
    var password: String?
    
    init(username: String?, password: String?) {
        self.username = username
        self.password = password
    }
    
    var hashedPassword: String {
        password?.sha256(salt: PASSWORD_SALT).hexString ?? ""
    }
    
    func isUsernameExisting() -> Bool {
        guard let username = username, let _ = CompanyDao.fetchCompanyPasswordBy(username: username) else {
            return false
        }
        return true
    }
    
    func areCredentialsValid() -> Bool {
        guard let username = username,
            let password = CompanyDao.fetchCompanyPasswordBy(username: username),
            password == hashedPassword
        else {
            return false
        }
        return true
    }
    
    func setLoggedInCompany() throws {
        guard let username = username, let company = CompanyDao.fetchCompanyBy(username: username) else {
            throw OptionalsError.incomplete
        }
        company.dao.setAsLoggedIn()
    }
    
}
