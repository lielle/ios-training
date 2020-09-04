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
    
    func removePreviousControllers() {
        let visibleVc = (navigationController?.visibleViewController)! as UIViewController
        navigationController?.setViewControllers([visibleVc], animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removePreviousControllers()
        loginView.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    deinit {
        print("LoginController deinit called")
    }

}

// MARK: - Button Events
extension LoginController: LoginViewDelegate {
    
    func onLogin() {
        if isLoginValid() {
            onValidLogin()
            self.performSegue(withIdentifier: "loginToSplash", sender: nil)
        }
    }
    
    func onSignup() {
        self.performSegue(withIdentifier: "loginToRegister", sender: nil)
    }

}
