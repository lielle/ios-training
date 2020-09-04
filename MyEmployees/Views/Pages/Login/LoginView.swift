//
//  LoginView.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/1/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func onLogin()
    func onSignup()
}

@IBDesignable
class LoginView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    weak var delegate: LoginViewDelegate?
    
    var isPasswordShown = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup(){
        contentView = loadViewFromNib(nibName: "LoginView")
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = self.bounds
        addSubview(contentView)
        setupViews()
    }
    
    func setupViews() {
        usernameField.delegate = self
        passwordField.delegate = self
        usernameField.setRightPaddingPoints(30)
        passwordField.setRightPaddingPoints(30)
    }

    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view
    }

}

// MARK: - Button Events
extension LoginView {
    
    @IBAction func onPasswordVisibilityToggled(_ sender: Any) {
        isPasswordShown = !isPasswordShown
        
        let imageName = isPasswordShown ? "eye" : "eye.slash"
        passwordVisibilityButton.setImage(UIImage(systemName: imageName), for: .normal)
        passwordField.isSecureTextEntry = !isPasswordShown
    }
    
    @IBAction func onLogin(_ sender: Any) {
        self.delegate?.onLogin()
    }
    @IBAction func onSignup(_ sender: Any) {
        self.delegate?.onSignup()
    }
    
}

// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        }
        catch {
            print("ERROR")
        }
        return true
    }
    
}
