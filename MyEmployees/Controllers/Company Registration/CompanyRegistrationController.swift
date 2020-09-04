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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UIApplication.shared.windows.first?.rootViewController = segue.destination
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
        guard validateCompany() else {
            return
        }
        
        addCompany()
        displayOkAlert(title: Label.REGISTRATION_SUCCESS, message: Label.REGISTRATION_SUCCESS_MESSAGE) {
            self.performSegue(withIdentifier: "registerToLogin", sender: nil)
        }
    }
    
    func onBackToLogin() {
        self.performSegue(withIdentifier: "registerToLogin", sender: nil)
    }
    
}
