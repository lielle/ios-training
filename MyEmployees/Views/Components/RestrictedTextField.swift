//
//  NumberTextField.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/4/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation
import UIKit

class RestrictedTextField: UITextField {
    
    @IBInspectable var allowAlphanumericOnly: Bool = false
    @IBInspectable var allowNumbersOnly: Bool = false

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        do {
            guard allowNumbersOnly || allowAlphanumericOnly else {
                return true
            }
            
            let pattern = allowNumbersOnly ? ".*[^0-9].*" : allowAlphanumericOnly ? ".*[^A-Za-z0-9].*" : ""
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        }
        catch {
            print("ERROR")
        }
        return true
    }
    
}
