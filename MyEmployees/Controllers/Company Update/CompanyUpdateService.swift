//
//  CompanyUpdateService.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/4/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

extension CompanyUpdateController {

    func updateCompany() {
        let username = companyView.usernameField.text ?? ""
        let contact = companyView.contactField.text ?? ""
        let address = companyView.addressTextView.text ?? ""
        
        company.username = username
        company.contact = contact
        company.address = address
        
        replaceImage(named: company.logoKey!, to: companyView.logoImageButton.currentImage!)
        company.dao.setAsLoggedIn()
        company.dao.update()
    }
    
}

// MARK: - Validations
extension CompanyUpdateController {
    
    // emptiness checking
    
    func isUsernameSupplied() -> Bool {
        let isEmpty = companyView.usernameField.text?.isEmpty ?? true
        return !isEmpty
    }
    
    // duplicate checking
    
    func isUsernameUnique() -> Bool {
        guard let username = companyView.usernameField.text, let _ = CompanyDao.fetchCompanyBy(username: username) else {
            return true
        }
        return false
    }
    
    func validateCompany() -> Bool {
        guard isUsernameSupplied() else {
            displayOkAlert(title: Label.COMPANY_UPDATE_ERROR, message: Label.REQUIRED_USERNAME_ERROR)
            return false
        }
        guard isUsernameUnique() else {
            displayOkAlert(title: Label.COMPANY_UPDATE_ERROR, message: Label.DUPLICATE_USERNAME_ERROR)
            return false
        }
        return true
    }
    
}
