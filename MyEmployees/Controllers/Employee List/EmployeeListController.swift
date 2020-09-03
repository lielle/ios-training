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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        }
        if segue.destination is LoginController {
            UIApplication.shared.windows.first?.rootViewController = segue.destination
        }
    }
    
    deinit {
        print("EmployeeListController deinit called")
    }
    
    @IBAction func onAddEmployee(_ sender: Any) {
        selectedEmployee = nil
        viewEmployeeForm()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        self.performSegue(withIdentifier: "employeeToLogin", sender: nil)
    }
    
    func viewEmployeeForm() {
        self.performSegue(withIdentifier: "employeeToForm", sender: nil)
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
//            let person = self.persons[indexPath.row]
//            self.persons.remove(at: indexPath.row)
//            DatabaseHelper.shared.delete(id: person.id!)
//            self.personTableView.reloadData()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem])
        return swipeActions
    }
    
}

// MARK: - UITableViewDataSource
extension EmployeeListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EmployeeCell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmployeeCell.self)) as! EmployeeCell
        let rowEmployee = employees[indexPath.row]
        cell.logoImageView.image = getImage(name: (rowEmployee.logoKey)!)
        cell.nameLabel.text = rowEmployee.name
        cell.positionLabel.text = Employee.POSITIONS[rowEmployee.positionId!]
        
        return cell
    }
    
}

// MARK: - EmployeeFilterControllerDelegate
extension EmployeeListController: EmployeeFilterControllerDelegate {
    
    func onFilterApplied(positionId: Int?) {
        if let positionId = positionId {
            employees = EmployeeDao.filterEmployees(of: company.id!, by: positionId)
        } else {
            employees = EmployeeDao.searchEmployees(of: company.id!, keyword: "")
        }
        employeeListView.tableView.reloadData()
    }
    
}

// MARK: - EmployeeListViewDelegate
extension EmployeeListController: EmployeeListViewDelegate {
    
    func onFilter() {
        self.performSegue(withIdentifier: "employeeToFilter", sender: nil)
    }
    
    func onSearch() {
        employees = EmployeeDao.searchEmployees(of: company.id!, keyword: employeeListView.searchField.text ?? "")
        employeeListView.tableView.reloadData()
    }
    
}

// MARK: - EmployeeFormControllerDelegate
extension EmployeeListController: EmployeeFormControllerDelegate {

    func onSave() {
        employees = EmployeeDao.fetchEmployees(of: company.id!)
        employeeListView.tableView.reloadData()
    }

}
