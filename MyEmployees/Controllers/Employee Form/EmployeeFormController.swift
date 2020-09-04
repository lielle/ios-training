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

}

// MARK: - EmployeeFormViewDelegate
extension EmployeeFormController: EmployeeFormViewDelegate {
    
    func onSave() {
        getEmployeeDetailsFromForm()
        guard let employee = employee, validateEmployee() else {
            return
        }
        
        if employee.id == nil {
            self.addEmployee()
        } else {
            self.updateEmployee()
        }
    }
    
    var viewController: UIViewController {
        return self
    }
    
}
