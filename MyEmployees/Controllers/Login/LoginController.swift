//
//  LoginController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var loginView: LoginView!
    
    var hashedPassword: String?
    let userPreferences = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(onLogin(_:)), for: .touchUpInside)
        loginView.signupButton.addTarget(self, action: #selector(onSignUp(_:)), for: .touchUpInside)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeFromParent()
        dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UIApplication.shared.windows.first?.rootViewController = segue.destination
    }
    
    deinit {
        print("Login deinit called")
    }

}

// MARK: - Button Events
extension LoginController {
    
    @objc func onLogin(_ sender: Any) {
        if isLoginValid() {
            onValidLogin()
            
            self.performSegue(withIdentifier: "loginToSplash", sender: nil)
        }
    }
    
    @objc func onSignUp(_ sender: Any) {
        self.performSegue(withIdentifier: "loginToRegister", sender: nil)
    }

}
