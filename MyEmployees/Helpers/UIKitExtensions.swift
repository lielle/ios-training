//
//  ProgressViewExtensions.swift
//  MyEmployees
//
//  Created by escience on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIViewController
extension UIViewController {
    
    func displayOkAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let completion = completion {
                completion()
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UIProgressView
extension UIProgressView {
    
    @available(iOS 10.0, *)
    func setAnimatedProgress(progress: Float = 1, duration: Float = 1, completion: (() -> ())? = nil) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            let current = self.progress
            self.setProgress(current + (1/duration), animated: true)
            if self.progress >= progress {
                timer.invalidate()
                if let completion = completion {
                    completion()
                }
            }
        }
    }
    
}

// MARK: - UITextView
extension UITextView {
    
    func addDefaultBorders() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
}

// MARK: - UIImage
extension UIImage {
    
    func saveAsJpg(_ name: String) {
        if let data = self.jpegData(compressionQuality: 0.8) {
            let filename = getDocumentsDirectory().appendingPathComponent("\(name).\(JPEG_EXTENSION)")
            try? data.write(to: filename)
        }
    }
    
}
