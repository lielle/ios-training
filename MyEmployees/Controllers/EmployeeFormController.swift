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
    
    deinit {
        print("EmployeeFormController deinit called")
    }
    
    func getEmployeeDetailsFromForm() {
        let name = employeeFormView.nameField.text ?? ""
        let contact = employeeFormView.contactField.text ?? ""
        let address = employeeFormView.addressTextView.text ?? ""
        let positionId = employeeFormView.selectedPosition?.id ?? 0
        
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

// MARK: - Init
extension EmployeeFormController {
    
    func initCompanyField() {
        company = CompanyDao.getLoggedIn()
        employeeFormView.companyField.text = company.name
    }
    
    func initEmployeeFields() {
        guard let employee = employee else {
            return
        }
        
        if let selectedIndex = employeeFormView.positionDropdown.items.firstIndex(where: { item in
            return item.retrievableValue as! Int == employee.positionId
        }) {
            employeeFormView.selectedPosition = employeeFormView.positionDropdown.items[selectedIndex] as? EmployeePosition
            employeeFormView.positionDropdown.selectedIndex = selectedIndex
        }
        
        employeeFormView.positionDropdown.placeHolderText = Employee.DEFAULT_POSITIONS[employee.positionId]
        
        employeeFormView.logoImageButton.setImage(FileHelper.getImage(named: employee.logoKey), for: .normal)
        employeeFormView.nameField.text = employee.name
        employeeFormView.contactField.text = employee.contact
        employeeFormView.addressTextView.text = employee.address
    }
    
}

// MARK: - EmployeeFormViewDelegate
extension EmployeeFormController: EmployeeFormViewDelegate {
    
    func onSave() {
        getEmployeeDetailsFromForm()
        guard let employee = employee else {
            return
        }
        
        let formService = EmployeeFormService(employee: employee, name: employeeFormView.nameField.text, positionId: employeeFormView.selectedPosition?.id, contact: employeeFormView.contactField.text, address: employeeFormView.addressTextView.text, logo: employeeFormView.logoImageButton.currentImage!)
        
        guard formService.isNameSupplied() else {
            displayOkAlert(title: Label.EMPLOYEE_DETAILS_ERROR, message: Label.REQUIRED_NAME_ERROR)
            return
        }
        guard formService.isPositionSupplied() else {
            displayOkAlert(title: Label.EMPLOYEE_DETAILS_ERROR, message: Label.REQUIRED_POSITION_ERROR)
            return
        }
        
        if employee.id == nil {
            formService.addEmployee()
            displayOkAlert(title: "Successfully saved", message: "New employee has been saved.") {
                self.delegate?.onSave()
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            formService.updateEmployee()
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
