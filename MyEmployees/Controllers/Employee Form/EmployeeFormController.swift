//
//  EmployeeFormController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class EmployeeFormController: UIViewController {
    
    @IBOutlet var employeeFormView: EmployeeFormView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeFormView.delegate = self
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        UIApplication.shared.windows.first?.rootViewController = segue.destination
    }
    
    deinit {
        print("EmployeeFormController deinit called")
    }

}

// MARK: - EmployeeFormProtocol
extension EmployeeFormController: EmployeeFormProtocol {
    
    var viewController: UIViewController {
        return self
    }
    
}
