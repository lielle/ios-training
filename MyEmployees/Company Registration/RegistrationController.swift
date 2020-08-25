//
//  RegistrationController.swift
//  MyEmployees
//
//  Created by escience on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logoImageButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var contactField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    
    var imagePicker = UIImagePickerController()
    let logoKey = UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTextView?.addDefaultBorders()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.flashScrollIndicators()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
}

// MARK: - Text Field/View Events
extension RegistrationController {
    
    @IBAction func nameStartEditing(_ sender: Any) {
        nameField.backgroundColor = UIColor.white.withAlphaComponent(0)
    }
    
    @IBAction func nameFinishedEditing(_ sender: Any) {
        guard isNameValid() else {
            nameField.backgroundColor = UIColor.red.withAlphaComponent(0.2)
            return
        }
    }
    
}

// MARK: - Button Events
extension RegistrationController {
    
    @IBAction func onChooseLogo(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            imagePicker.modalPresentationStyle = .overCurrentContext
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func onRegister(_ sender: Any) {
        guard let company = getValidCompany() else {
            return
        }
        DatabaseHelper.shared.insert(company: company)
        logoImageButton.currentImage?.saveAsJpg(company.logoKey!)
        
        displayOkAlert(title: "Successfully registered", message: "Registration complete.")
    }
    
    @IBAction func onBackToLogin(_ sender: Any) {
        let controller = LoginController()
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: true, completion: nil)
    }
    
}

// MARK: - Image Controller Delegate
extension RegistrationController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        logoImageButton.setImage(image, for: .normal)
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Validations
extension RegistrationController {
    
    func isNameValid() -> Bool {
        // special chars not allowed
        let isEmpty = nameField.text?.isEmpty ?? true
        if isEmpty {
            displayOkAlert(title: "Registration Error", message: "Name is required")
        }
        
        return !isEmpty
    }
    
    func isUsernameValid() -> Bool {
        let isEmpty = usernameField.text?.isEmpty ?? true
        if isEmpty {
            displayOkAlert(title: "Registration Error", message: "Username is required")
        }
        
        return !isEmpty
    }
    
    func isPasswordValid() -> Bool {
        // special chars not allowed
        // at least 1 uppercase, 1 lowercase and 1 number
        let isEmpty = passwordField.text?.isEmpty ?? true
        
        if isEmpty {
            displayOkAlert(title: "Registration Error", message: "Password is required")
        }
        return !isEmpty
    }
    
    func isContactValid() -> Bool {
        let isEmpty = contactField.text?.isEmpty ?? true
        return !isEmpty
    }
    
    func getValidCompany() -> Company? {
        guard let name = nameField.text, isNameValid() else {
            return nil
        }
        guard let username = usernameField.text, isUsernameValid() else {
            return nil
        }
        guard let password = passwordField.text, isPasswordValid() else {
            return nil
        }
        guard let contact = contactField.text, isContactValid() else {
            return nil
        }
        guard let address = addressTextView.text else {
            return nil
        }
        
        let company = Company(name: name, username: username, password: password.sha256(salt: PASSWORD_SALT).hexString, contact: contact, address: address, logoKey: logoKey)
        return company
    }
    
}
