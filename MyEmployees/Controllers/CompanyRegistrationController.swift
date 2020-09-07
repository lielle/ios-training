//
//  CompanyRegistrationController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class CompanyRegistrationController: UIViewController {
    
    @IBOutlet var companyView: CompanyView!
    
    func removePreviousControllers() {
        let visibleVc = (navigationController?.visibleViewController)! as UIViewController
        navigationController?.setViewControllers([visibleVc], animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removePreviousControllers()
        companyView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    deinit {
        print("CompanyRegistrationController deinit called")
    }
    
}

extension CompanyRegistrationController: CompanyViewDelegate {
    
    var viewController: UIViewController {
        return self
    }
    
    func onRegister() {
        let registrationService = CompanyRegistrationService(name: companyView.nameField.text, username: companyView.usernameField.text, password: companyView.passwordField.text, contact: companyView.contactField.text, address: companyView.addressTextView.text, logo: companyView.logoImageButton.currentImage ?? UIImage())
        
        guard registrationService.isNameSupplied() else {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.REQUIRED_NAME_ERROR)
            return
        }
        guard registrationService.isUsernameSupplied() else {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.REQUIRED_USERNAME_ERROR)
            return
        }
        guard registrationService.isUsernameUnique() else {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.DUPLICATE_USERNAME_ERROR)
            return
        }
        guard registrationService.isPasswordSupplied() else {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.REQUIRED_PASSWORD_ERROR)
            return
        }
        guard registrationService.isPasswordSecured() else {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.PASSWORD_SECURITY_ERROR)
            return
        }
        
        do {
            try registrationService.addCompany()
        } catch {
            displayOkAlert(title: Label.REGISTRATION_ERROR, message: Label.REGISTRATION_FAILURE)
            return
        }
        displayOkAlert(title: Label.REGISTRATION_SUCCESS, message: Label.REGISTRATION_SUCCESS_MESSAGE) {
            self.performSegue(withIdentifier: "registerToLogin", sender: nil)
        }
    }
    
    func onBackToLogin() {
        self.performSegue(withIdentifier: "registerToLogin", sender: nil)
    }
    
}
