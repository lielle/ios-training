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
        loginView.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UIApplication.shared.windows.first?.rootViewController = segue.destination
    }
    
    deinit {
        print("LoginController deinit called")
    }

}

// MARK: - Button Events
extension LoginController: LoginProtocol {
    
    func onLogin() {
        self.performSegue(withIdentifier: "loginToSplash", sender: nil) // remove
        if isLoginValid() {
            onValidLogin()
            self.performSegue(withIdentifier: "loginToSplash", sender: nil)
        }
    }
    
    func onSignup() {
        self.performSegue(withIdentifier: "loginToRegister", sender: nil)
    }

}
