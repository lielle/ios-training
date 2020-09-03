//
//  LoginService.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/30/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

extension LoginController {
    
    func onValidLogin() {
        guard let company = CompanyDao.fetchCompanyBy(username: loginView.usernameField.text!) else {
            displayOkAlert(title: "Login", message: "Company not found.")
            return
        }
        CompanyDao.setLoggedIn(company: company)
    }
    
}

// MARK: - Validations
extension LoginController {
    
    func isUsernameExisting() -> Bool {
        guard let _ = CompanyDao.fetchCompanyPasswordBy(username: loginView.usernameField.text!) else {
            displayOkAlert(title: "Login", message: "Username does not exist.")
            return false
        }
        return true
    }
    
    func areCredentialsValid() -> Bool {
        guard let password = CompanyDao.fetchCompanyPasswordBy(username: loginView.usernameField.text!), password == hashedPassword else {
            displayOkAlert(title: "Login", message: "Username and password do not match.")
            return false
        }
        return true
    }
    
    func isLoginValid() -> Bool {
        hashedPassword = loginView.passwordField.text?.sha256(salt: PASSWORD_SALT).hexString
        guard isUsernameExisting() && areCredentialsValid() else {
            return false
        }
        return true
    }
    
}
