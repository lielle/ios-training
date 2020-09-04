//
//  CompanyView.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/1/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

// MARK: - CompanyViewDelegate
protocol CompanyViewDelegate: AnyObject {
    var viewController: UIViewController { get }
    func onRegister()
    func onBackToLogin()
}

extension CompanyViewDelegate {
    func onBackToLogin() {
    }
}

// MARK: - CompanyView
@IBDesignable
class CompanyView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logoImageButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var contactField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    
    @IBOutlet weak var passwordStackView: UIStackView!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    
    weak var delegate: CompanyViewDelegate?
    
    var isPasswordShown = false
    var imagePicker = UIImagePickerController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib(nibName: "CompanyView")
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = self.bounds
        addSubview(contentView)
        
        passwordField.setRightPaddingPoints(30)
        addressTextView?.addDefaultBorders()
        scrollView.flashScrollIndicators()
    }

    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view
    }
    
}

// MARK: - Button Events
extension CompanyView {
    
    @IBAction func onPasswordVisibilityToggled(_ sender: Any) {
        isPasswordShown = !isPasswordShown
        
        let imageName = isPasswordShown ? "eye" : "eye.slash"
        passwordVisibilityButton.setImage(UIImage(systemName: imageName), for: .normal)
        passwordField.isSecureTextEntry = !isPasswordShown
    }
    
    @IBAction func onChooseLogo(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            imagePicker.modalPresentationStyle = .overCurrentContext
            self.delegate?.viewController.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func onRegister(_ sender: Any) {
        self.delegate?.onRegister()
    }
    
    @IBAction func onBackToLogin(_ sender: Any) {
        self.delegate?.onBackToLogin()
    }
    
}

// MARK: - Image Controller Delegate
extension CompanyView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        logoImageButton.setImage(image, for: .normal)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
