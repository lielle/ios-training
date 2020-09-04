//
//  EmployeeFilterController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

protocol EmployeeFilterControllerDelegate: AnyObject {
    func onFilterApplied(position: EmployeePosition?, index: Int?)
}

class EmployeeFilterController: UIViewController {
    
    @IBOutlet var employeeFilterView: EmployeeFilterView!
    
    weak var delegate: EmployeeFilterControllerDelegate?
    
    var selectedPosition: EmployeePosition? = nil
    var selectedPositionIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeFilterView.delegate = self
        
        if let selectedPositionIndex = selectedPositionIndex, let selectedPosition = selectedPosition {
            employeeFilterView.positionDropdown.selectedIndex = selectedPositionIndex
            employeeFilterView.positionDropdown.placeHolderText = selectedPosition.description
        }
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
        let position = employeeFilterView.selectedPosition
        let index = employeeFilterView.selectedPositionIndex
        
        self.delegate?.onFilterApplied(position: position, index: index)
    }
    
    var viewController: UIViewController {
        self
    }
    
}
