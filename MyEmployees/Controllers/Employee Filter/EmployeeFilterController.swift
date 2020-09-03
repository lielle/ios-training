//
//  EmployeeFilterController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

protocol EmployeeFilterControllerDelegate: AnyObject {
    func onFilterApplied(positionId: Int?)
}

class EmployeeFilterController: UIViewController {
    
    @IBOutlet var employeeFilterView: EmployeeFilterView!
    
    weak var delegate: EmployeeFilterControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeFilterView.delegate = self
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.backgroundColor = .none
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    deinit {
        print("EmployeeFilterController deinit called")
    }

}

// MARK: - EmployeeFilterViewDelegate
extension EmployeeFilterController: EmployeeFilterViewDelegate {
    
    func onFilter() {
        var positionId: Int? = nil
        if let index = employeeFilterView.positionDropdown.selectedIndex {
            let position = employeeFilterView.positionDropdown.items[index] as! EmployeePosition
            positionId = position.id
        }
        
        self.delegate?.onFilterApplied(positionId: positionId)
    }
    
    var viewController: UIViewController {
        self
    }
    
}
