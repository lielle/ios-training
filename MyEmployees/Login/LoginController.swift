//
//  LoginController.swift
//  MyEmployees
//
//  Created by escience on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private var hashedPassword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if isLoginValid() {
            print("Login success")
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let controller = RegistrationController()
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: true, completion: nil)
    }

}

// MARK: - Validations
extension LoginController {
    
    func isUsernameExisting() -> Bool {
        guard let _ = DatabaseHelper.shared.fetchCompanyPasswordBy(username: usernameField.text!) else {
            displayOkAlert(title: "Login", message: "Username does not exist.")
            return false
        }
        return true
    }
    
    func areCredentialsValid() -> Bool {
        guard let password = DatabaseHelper.shared.fetchCompanyPasswordBy(username: usernameField.text!), password == hashedPassword else {
            displayOkAlert(title: "Login", message: "Username and password do not match.")
            return false
        }
        return true
    }
    
    func isLoginValid() -> Bool {
        hashedPassword = passwordField.text?.sha256(salt: PASSWORD_SALT).hexString
        guard isUsernameExisting() && areCredentialsValid() else {
            return false
        }
        return true
    }
    
}