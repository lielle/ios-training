//
//  EmployeeListController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/27/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class EmployeeListController: UIViewController {

    @IBOutlet var employeeListView: EmployeeListView!
    
    var company: Company!
    var employees: [Employee]!
    var selectedEmployee: Employee? = nil
    
    var searchText: String? = ""
    var filterPosition: EmployeePosition? = nil
    var filterPositionIndex: Int? = nil
    
    func removePreviousControllers() {
        let visibleVc = (navigationController?.visibleViewController)! as UIViewController
        navigationController?.setViewControllers([visibleVc], animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removePreviousControllers()
        
        guard let loggedCompany = CompanyDao.getLoggedIn() else {
            return
        }
        company = loggedCompany
        
        employees = EmployeeDao.fetchEmployees(of: company.id!)
        employeeListView.delegate = self
        
        employeeListView.tableView.register(UINib(nibName: String(describing: EmployeeCell.self), bundle: nil), forCellReuseIdentifier: String(describing: EmployeeCell.self))
        employeeListView.tableView.delegate = self
        employeeListView.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is EmployeeFormController {
            let vc = segue.destination as! EmployeeFormController
            vc.employee = selectedEmployee
            vc.delegate = self
        }
        if segue.destination is EmployeeFilterController {
            let vc = segue.destination as! EmployeeFilterController
            vc.delegate = self
            vc.selectedPosition = filterPosition
            vc.selectedPositionIndex = filterPositionIndex
        }
    }
    
    deinit {
        print("EmployeeListController deinit called")
    }
    
    func viewEmployeeForm() {
        self.performSegue(withIdentifier: "employeeToForm", sender: nil)
    }
    
    func applyFilters() {
        let positionId = filterPosition?.id == 0 ? nil : filterPosition?.id
        employees = EmployeeDao.filterEmployees(of: company.id!, by: positionId, keyword: employeeListView.searchField.text ?? "")
        employeeListView.tableView.reloadData()
    }

}

// MARK: Button actions
extension EmployeeListController {
    
    @IBAction func onAddEmployee(_ sender: Any) {
        selectedEmployee = nil
        viewEmployeeForm()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "company")
        self.performSegue(withIdentifier: "employeeToLogin", sender: nil)
    }
    
}

// MARK: - UITableViewDelegate
extension EmployeeListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedEmployee = employees[indexPath.row]
        viewEmployeeForm()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") {(contextualAction, view, boolValue) in
            let rowEmployee = self.employees[indexPath.row]
            self.employees.remove(at: indexPath.row)
            rowEmployee.dao.delete()
            self.employeeListView.tableView.reloadData()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem])
        return swipeActions
    }
    
}

// MARK: - UITableViewDataSource
extension EmployeeListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if employees.count > 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections = 1
            tableView.backgroundView = nil
        } else {
            let noDataView = EmptyTableView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            tableView.backgroundView = noDataView
            tableView.separatorStyle = .none
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EmployeeCell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmployeeCell.self)) as! EmployeeCell
        let rowEmployee = employees[indexPath.row]
        cell.logoImageView.image = getImage(named: (rowEmployee.logoKey)!)
        cell.nameLabel.text = rowEmployee.name
        cell.positionLabel.text = Employee.DEFAULT_POSITIONS[rowEmployee.positionId!]
        
        return cell
    }
    
}

// MARK: - EmployeeFilterControllerDelegate
extension EmployeeListController: EmployeeFilterControllerDelegate {
    
    func onFilterApplied(position: EmployeePosition?, index: Int?) {
        filterPosition = position
        filterPositionIndex = index
        applyFilters()
    }
    
}

// MARK: - EmployeeListViewDelegate
extension EmployeeListController: EmployeeListViewDelegate {
    
    func onFilter() {
        self.performSegue(withIdentifier: "employeeToFilter", sender: nil)
    }
    
    func onSearch() {
        applyFilters()
    }
    
}

// MARK: - EmployeeFormControllerDelegate
extension EmployeeListController: EmployeeFormControllerDelegate {

    func onSave() {
        employees = EmployeeDao.fetchEmployees(of: company.id!)
        employeeListView.tableView.reloadData()
    }

}
