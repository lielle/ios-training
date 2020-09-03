//
//  EmployeeFormView.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import SwiftyMenu
import UIKit

protocol EmployeeFormViewDelegate: AnyObject {
    var viewController: UIViewController { get }
    func onSave()
}

@IBDesignable
class EmployeeFormView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logoImageButton: UIButton!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var positionDropdown: SwiftyMenu!
    @IBOutlet weak var contactField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    
    weak var delegate: EmployeeFormViewDelegate?
    
    var imagePicker = UIImagePickerController()
    var selectedPosition: EmployeePosition?
    var selectedPositionIndex: Int?
    let positions: [SwiftyMenuDisplayable] = EmployeePosition.array(of: Employee.POSITIONS)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib(nibName: "EmployeeFormView")
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = self.bounds
        addSubview(contentView)
        
        positionDropdown.delegate = self
        positionDropdown.items = positions
        
        companyField.borderStyle = .none
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
extension EmployeeFormView {
    
    @IBAction func onChooseLogo(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            imagePicker.modalPresentationStyle = .overCurrentContext
            self.delegate?.viewController.present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction func onSave(_ sender: Any) {
        delegate?.onSave()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        delegate?.viewController.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - SwiftyMenuDelegate
extension EmployeeFormView: SwiftyMenuDelegate {
    
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        selectedPositionIndex = index
        selectedPosition = item as? EmployeePosition
    }
    
}

// MARK: - Image Controller Delegate
extension EmployeeFormView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        logoImageButton.setImage(image, for: .normal)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
