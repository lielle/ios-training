//
//  RegistrationService.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/30/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

// MARK: - Validations
extension RegistrationController {
    
//    func isNameValid() -> Bool {
//        // special chars not allowed
//        let isEmpty = nameField.text?.isEmpty ?? true
//        if isEmpty {
//            displayOkAlert(title: "Registration Error", message: "Name is required")
//        }
//        
//        return !isEmpty
//    }
//    
//    func isUsernameValid() -> Bool {
//        let isEmpty = usernameField.text?.isEmpty ?? true
//        if isEmpty {
//            displayOkAlert(title: "Registration Error", message: "Username is required")
//        }
//        
//        return !isEmpty
//    }
//    
//    func isPasswordValid() -> Bool {
//        // special chars not allowed
//        // at least 1 uppercase, 1 lowercase and 1 number
//        let isEmpty = passwordField.text?.isEmpty ?? true
//        
//        if isEmpty {
//            displayOkAlert(title: "Registration Error", message: "Password is required")
//        }
//        return !isEmpty
//    }
//    
//    func isContactValid() -> Bool {
//        let isEmpty = contactField.text?.isEmpty ?? true
//        return !isEmpty
//    }
//    
//    func getValidCompany() -> Company? {
//        guard let name = nameField.text, isNameValid() else {
//            return nil
//        }
//        guard let username = usernameField.text, isUsernameValid() else {
//            return nil
//        }
//        guard let password = passwordField.text, isPasswordValid() else {
//            return nil
//        }
//        guard let contact = contactField.text, isContactValid() else {
//            return nil
//        }
//        guard let address = addressTextView.text else {
//            return nil
//        }
//        
//        let company = Company(name: name, username: username, password: password.sha256(salt: PASSWORD_SALT).hexString, contact: contact, address: address, logoKey: logoKey)
//        return company
//    }
    
}
