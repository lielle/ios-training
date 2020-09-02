//
//  RegistrationService.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/30/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

extension RegistrationController: CompanyProtocol {
    
    var viewController: UIViewController {
        return self
    }
    
    func isNameValid() -> Bool {
        // special chars not allowed
        let isEmpty = companyView.nameField.text?.isEmpty ?? true
        if isEmpty {
            displayOkAlert(title: "Registration Error", message: "Name is required")
        }
        
        return !isEmpty
    }
    
    func onRegister() {
        guard let company = getValidCompany() else {
            return
        }
        DatabaseHelper.shared.insert(company: company)
        companyView.logoImageButton.currentImage?.saveAsJpg(company.logoKey!)

        displayOkAlert(title: "Successfully registered", message: "Registration complete.")
    }
    
    func onBackToLogin() {
        self.performSegue(withIdentifier: "registerToLogin", sender: nil)
    }
    
}

// MARK: - Validations
extension RegistrationController {
    
    
    func isUsernameValid() -> Bool {
        let isEmpty = companyView.usernameField.text?.isEmpty ?? true
        if isEmpty {
            displayOkAlert(title: "Registration Error", message: "Username is required")
        }
        
        return !isEmpty
    }
    
    func isPasswordValid() -> Bool {
        // special chars not allowed
        // at least 1 uppercase, 1 lowercase and 1 number
        let isEmpty = companyView.passwordField.text?.isEmpty ?? true
        
        if isEmpty {
            displayOkAlert(title: "Registration Error", message: "Password is required")
        }
        return !isEmpty
    }
    
    func isContactValid() -> Bool {
        let isEmpty = companyView.contactField.text?.isEmpty ?? true
        return !isEmpty
    }
    
    func getValidCompany() -> Company? {
        guard let name = companyView.nameField.text, isNameValid() else {
            return nil
        }
        guard let username = companyView.usernameField.text, isUsernameValid() else {
            return nil
        }
        guard let password = companyView.passwordField.text, isPasswordValid() else {
            return nil
        }
        guard let contact = companyView.contactField.text, isContactValid() else {
            return nil
        }
        guard let address = companyView.addressTextView.text else {
            return nil
        }
        
        let company = Company(name: name, username: username, password: password.sha256(salt: PASSWORD_SALT).hexString, contact: contact, address: address, logoKey: logoKey)
        return company
    }
    
}
