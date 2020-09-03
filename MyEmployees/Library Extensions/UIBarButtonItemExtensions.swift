//
//  UIBarButtonItemExtensions.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/3/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    @IBInspectable var fontSize: CGFloat {
        get {
            return self.fontSize
        }
        set {
            self.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: newValue)], for: .normal)
        }
    }
    
}
