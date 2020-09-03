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
    
    let userPreferences = UserDefaults.standard
    weak var company: Company!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let loggedCompany = userPreferences.value(Company.self, forKey: "company") else {
            return
        }
        company = loggedCompany
        
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
        companyView.logoImageButton.setImage(getImage(name: company.logoKey!), for: .normal)
        companyView.nameField.text = company.name
        companyView.usernameField.text = company.username
        companyView.contactField.text = company.contact
        companyView.addressTextView.text = company.address
    }

    @IBAction func onLogout(_ sender: Any) {
        self.performSegue(withIdentifier: "companyToLogin", sender: nil)
    }
    
}
