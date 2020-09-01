//
//  LoginView.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/1/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

@IBDesignable
class LoginView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
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
    
}
