//
//  EmployeeFormControllerService.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/4/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

extension EmployeeFormController {
    
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
    
    func addEmployee() {
        guard let employee = employee else {
            print("Unable to add employee. No employee object found.")
            return
        }
        
        employee.dao.insert()
        saveImage(employeeFormView.logoImageButton.currentImage, named: employee.logoKey!)
        displayOkAlert(title: "Successfully saved", message: "New employee has been saved.") {
            self.delegate?.onSave()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func updateEmployee() {
        guard let employee = employee else {
            print("Unable to edit employee. No employee object found.")
            return
        }
        
        employee.dao.update()
        replaceImage(named: employee.logoKey!, to: employeeFormView.logoImageButton.currentImage!)
        displayOkAlert(title: "Successfully updated", message: "Employee has been updated.") {
            self.delegate?.onSave()
            self.dismiss(animated: true, completion: nil)
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
            return item.retrievableValue as! Int == employee.positionId!
        }) {
            employeeFormView.selectedPosition = employeeFormView.positionDropdown.items[selectedIndex] as? EmployeePosition
            employeeFormView.positionDropdown.selectedIndex = selectedIndex
        }
        
        employeeFormView.positionDropdown.placeHolderText = Employee.DEFAULT_POSITIONS[employee.positionId!]
        
        employeeFormView.logoImageButton.setImage(getImage(named: employee.logoKey!), for: .normal)
        employeeFormView.nameField.text = employee.name
        employeeFormView.contactField.text = employee.contact
        employeeFormView.addressTextView.text = employee.address
    }
    
}

// MARK: - Validations
extension EmployeeFormController {
    
    // emptiness checking
    
    func isNameSupplied() -> Bool {
        guard let name = employee?.name, name != "" else {
            return false
        }
        return true
    }
    
    func isPositionSupplied() -> Bool {
        guard let position = employee?.positionId, position != 0 else {
            return false
        }
        return true
    }
    
    func validateEmployee() -> Bool {
        guard isNameSupplied() else {
            displayOkAlert(title: Label.EMPLOYEE_DETAILS_ERROR, message: Label.REQUIRED_NAME_ERROR)
            return false
        }
        guard isPositionSupplied() else {
            displayOkAlert(title: Label.EMPLOYEE_DETAILS_ERROR, message: Label.REQUIRED_POSITION_ERROR)
            return false
        }
        return true
    }
    
}
