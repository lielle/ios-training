//
//  RegistrationService.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/30/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

extension CompanyRegistrationController {
    
    func addCompany() {
        let name = companyView.nameField.text ?? ""
        let username = companyView.usernameField.text ?? ""
        let password = companyView.passwordField.text ?? ""
        let contact = companyView.contactField.text ?? ""
        let address = companyView.addressTextView.text ?? ""
        
        let company = Company(name: name, username: username, password: password.sha256(salt: PASSWORD_SALT).hexString, contact: contact, address: address, logoKey: UUID().uuidString)
        
        company.dao.insert()
        saveImage(companyView.logoImageButton.currentImage, named: company.logoKey!)
    }
    
}

// MARK: - Validations
extension CompanyRegistrationController {
    
    // emptiness checking
    
    func isNameSupplied() -> Bool {
        let isEmpty = companyView.nameField.text?.isEmpty ?? true
        return !isEmpty
    }
    
    func isUsernameSupplied() -> Bool {
        let isEmpty = companyView.usernameField.text?.isEmpty ?? true
        return !isEmpty
    }
    
    func isPasswordSupplied() -> Bool {
        let isEmpty = companyView.passwordField.text?.isEmpty ?? true
        return !isEmpty
    }
    
    // duplicate checking
    
    func isUsernameUnique() -> Bool {
        guard let username = companyView.usernameField.text, let _ = CompanyDao.fetchCompanyBy(username: username) else {
            return true
        }
        return false
    }
    
    // password validity
    
    func isPasswordSecured() -> Bool {
        // at least 1 uppercase, 1 lowercase and 1 number
        let password = companyView.passwordField.text!
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
    
    func validateCompany() -> Bool {
        guard isNameSupplied() else {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.REQUIRED_NAME_ERROR)
            return false
        }
        guard isUsernameSupplied() else {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.REQUIRED_USERNAME_ERROR)
            return false
        }
        guard isUsernameUnique() else {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.DUPLICATE_USERNAME_ERROR)
            return false
        }
        guard isPasswordSupplied() else {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.REQUIRED_PASSWORD_ERROR)
            return false
        }
        guard isPasswordSecured() else {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.PASSWORD_SECURITY_ERROR)
            return false
        }
        return true
    }
    
}
