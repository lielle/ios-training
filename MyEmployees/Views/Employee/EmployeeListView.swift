//
//  EmployeeView.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

protocol EmployeeProtocol: AnyObject {
    func onFilter()
    func onSearch()
}

@IBDesignable
class EmployeeListView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: EmployeeProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib(nibName: "EmployeeListView")
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = self.bounds
        addSubview(contentView)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160.0
    }

    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view
    }
    
    @IBAction func onSearch(_ sender: Any) {
        delegate?.onSearch()
    }
    
    @IBAction func onFilter(_ sender: Any) {
        delegate?.onFilter()
    }
    
}
