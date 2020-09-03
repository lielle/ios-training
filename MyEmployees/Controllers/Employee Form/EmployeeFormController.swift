//
//  EmployeeFormController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

protocol EmployeeFormControllerDelegate: AnyObject {
    func onSave()
}

class EmployeeFormController: UIViewController {
    
    @IBOutlet var employeeFormView: EmployeeFormView!
    
    weak var delegate: EmployeeFormControllerDelegate?
    
    var company: Company!
    var employee: Employee? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeFormView.delegate = self
        initCompanyField()
        initEmployeeFields()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    deinit {
        print("EmployeeFormController deinit called")
    }
    
    func initCompanyField() {
        company = CompanyDao.getLoggedIn()
        employeeFormView.companyField.text = company.name
    }
    
    func initEmployeeFields() {
        guard let employee = employee else {
            return
        }
        
        let selectedIndex = employeeFormView.positionDropdown.items.firstIndex { item in
            return item.retrievableValue as! Int == employee.positionId!
        }
        
        employeeFormView.positionDropdown.selectedIndex = selectedIndex
        employeeFormView.positionDropdown.placeHolderText = Employee.POSITIONS[employee.positionId!]
        
        employeeFormView.logoImageButton.setImage(getImage(name: employee.logoKey!), for: .normal)
        employeeFormView.nameField.text = employee.name
        employeeFormView.contactField.text = employee.contact
        employeeFormView.addressTextView.text = employee.address
    }
    
    func validateEmployee() {
        guard let name = employeeFormView.nameField.text else {
            return
        }
        guard let contact = employeeFormView.contactField.text else {
            return
        }
        guard let address = employeeFormView.addressTextView.text else {
            return
        }
        guard let positionId = employeeFormView.selectedPosition?.id else {
            return
        }
        
        if employee == nil || employee?.id == nil {
            employee = Employee(companyId: company.id!, name: name, positionId: positionId, contact: contact, address: address, logoKey: UUID().uuidString)
        } else {
            employee?.name = name
            employee?.positionId = positionId
            employee?.contact = contact
            employee?.address = address
        }
    }

}

// MARK: - EmployeeFormViewDelegate
extension EmployeeFormController: EmployeeFormViewDelegate {
    
    func onSave() {
        validateEmployee()
        
        guard let employee = employee else {
            return
        }
        
        if employee.id == nil {
            EmployeeDao.insert(employee: employee)
            employeeFormView.logoImageButton.currentImage?.saveAsJpg(employee.logoKey!)
            displayOkAlert(title: "Successfully saved", message: "New employee has been saved.") {
                self.delegate?.onSave()
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            displayOkAlert(title: "Successfully updated", message: "Employee has been updated.") {
                self.delegate?.onSave()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    var viewController: UIViewController {
        return self
    }
    
}
