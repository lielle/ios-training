//
//  CompanyUpdateController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class CompanyUpdateController: UIViewController {
    
    @IBOutlet weak var companyView: CompanyView!
    
    var company: Company!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let loggedCompany = CompanyDao.getLoggedIn() else {
            return
        }
        company = loggedCompany
        companyView.delegate = self
        
        initView()
        initCompanyFields()
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
        print("CompanyUpdateController deinit called")
    }
    
    func initView() {
        companyView.nameField.borderStyle = .none
        companyView.nameField.isUserInteractionEnabled = false
        companyView.passwordStackView.isHidden = true
        companyView.passwordVisibilityButton.isHidden = true
        companyView.registerButton.setTitle(Label.UPDATE_PROFILE, for: .normal)
        companyView.registerButton.backgroundColor = UIColor(named: "ESCMain2")
        companyView.backToLoginButton.isHidden = true
    }
    
    func initCompanyFields() {
        companyView.logoImageButton.setImage(getImage(named: company.logoKey!), for: .normal)
        companyView.nameField.text = company.name
        companyView.usernameField.text = company.username
        companyView.contactField.text = company.contact
        companyView.addressTextView.text = company.address
    }

    @IBAction func onLogout(_ sender: Any) {
        self.performSegue(withIdentifier: "companyToLogin", sender: nil)
    }
    
    func validateCompany() {
        guard let username = companyView.usernameField.text else {
            return
        }
        guard let contact = companyView.contactField.text else {
            return
        }
        guard let address = companyView.addressTextView.text else {
            return
        }
        
        company?.username = username
        company?.contact = contact
        company?.address = address
    }
    
}

// MARK: - CompanyViewDelegate
extension CompanyUpdateController: CompanyViewDelegate {
    
    var viewController: UIViewController {
        self
    }
    
    func onRegister() {
        validateCompany()
        replaceImage(named: company.logoKey!, to: companyView.logoImageButton.currentImage!)
        company.dao.setAsLoggedIn()
        company.dao.update()
        displayOkAlert(title: "Profile updated", message: "Your profile has been updated.")
    }
    
}
