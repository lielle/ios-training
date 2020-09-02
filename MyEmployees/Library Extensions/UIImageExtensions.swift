//
//  Extensions.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

extension UIImage {
    
    func saveAsJpg(_ name: String) {
        if let data = self.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent("\(name).\(JPEG_EXTENSION)")
            try? data.write(to: filename)
        }
    }
    
}
