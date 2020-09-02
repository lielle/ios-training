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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
//        UIApplication.shared.windows.first?.rootViewController = segue.destination
    }
    
    deinit {
        print("EmployeeListController deinit called")
    }
    
    @IBAction func onAddEmployee(_ sender: Any) {
        viewEmployeeForm()
    }
    
    func viewEmployeeForm() {
        self.performSegue(withIdentifier: "employeeToForm", sender: nil)
    }

}

// MARK: - UITableViewDelegate
extension EmployeeListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let person = persons[indexPath.row]
        viewEmployeeForm()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") {(contextualAction, view, boolValue) in
            // delete
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem])
        return swipeActions
    }
    
}

// MARK: - UITableViewDataSource
extension EmployeeListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EmployeeCell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmployeeCell.self)) as! EmployeeCell
        
        return cell
    }
    
}

// MARK: - EmployeeProtocol
extension EmployeeListController: EmployeeProtocol {
    
    func onFilter() {
        self.performSegue(withIdentifier: "employeeToFilter", sender: nil)
    }
    
    func onSearch() {
    }
    
}
