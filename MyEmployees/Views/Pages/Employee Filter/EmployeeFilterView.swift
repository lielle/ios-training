//
//  EmployeeFilterView.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import SwiftyMenu
import UIKit

protocol EmployeeFilterViewDelegate: AnyObject {
    var viewController: UIViewController { get }
    func onFilter()
}

@IBDesignable
class EmployeeFilterView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var positionDropdown: SwiftyMenu!
    
    weak var delegate: EmployeeFilterViewDelegate?
    
    let positions: [SwiftyMenuDisplayable] = EmployeePosition.DEFAULT_WITH_ALL_OPTION
    
    var selectedPosition: EmployeePosition? = nil
    var selectedPositionIndex: Int? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib(nibName: "EmployeeFilterView")
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = self.bounds
        addSubview(contentView)
        
        positionDropdown.delegate = self
        positionDropdown.items = positions
    }

    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view
    }

    @IBAction func onFilter(_ sender: Any) {
        delegate?.onFilter()
        delegate?.viewController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        delegate?.viewController.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - SwiftyMenuDelegate
extension EmployeeFilterView: SwiftyMenuDelegate {
    
    func swiftyMenu(_ swiftyMenu: SwiftyMenu, didSelectItem item: SwiftyMenuDisplayable, atIndex index: Int) {
        selectedPosition = item as? EmployeePosition
        selectedPositionIndex = index
    }
    
}
