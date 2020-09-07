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
        companyView.logoImageButton.setImage(FileHelper.getImage(named: company.logoKey), for: .normal)
        companyView.nameField.text = company.name
        companyView.usernameField.text = company.username
        companyView.contactField.text = company.contact
        companyView.addressTextView.text = company.address
    }
    
}

// MARK: - Button actions
extension CompanyUpdateController {

    @IBAction func onLogout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "company")
        self.performSegue(withIdentifier: "companyToLogin", sender: nil)
    }
    
}

// MARK: - CompanyViewDelegate
extension CompanyUpdateController: CompanyViewDelegate {
    
    var viewController: UIViewController {
        self
    }
    
    func onRegister() {
        let updateService = CompanyUpdateService(company: company, username: companyView.usernameField.text, contact: companyView.contactField.text, address: companyView.addressTextView.text, logo: companyView.logoImageButton.currentImage!)
        
        guard updateService.isUsernameSupplied() else {
            displayOkAlert(title: Label.COMPANY_UPDATE_ERROR, message: Label.REQUIRED_USERNAME_ERROR)
            return
        }
        guard updateService.isUsernameUnique() else {
            displayOkAlert(title: Label.COMPANY_UPDATE_ERROR, message: Label.DUPLICATE_USERNAME_ERROR)
            return
        }
        
        do {
            try updateService.update()
        } catch {
            displayOkAlert(title: Label.COMPANY_UPDATE_ERROR, message: Label.DUPLICATE_USERNAME_ERROR)
            return
        }
        
        displayOkAlert(title: Label.COMPANY_UPDATE_SUCCESS, message: Label.COMPANY_UPDATE_SUCCESS_MESSAGE)
    }
    
}
