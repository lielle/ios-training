//
//  Extensions.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

extension UIProgressView {
    
    @available(iOS 10.0, *)
    func setAnimatedProgress(progress: Float = 1, duration: Float = 1, completion: (() -> ())? = nil) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            DispatchQueue.main.async {
                let current = self.progress
                self.setProgress(current + (1/duration), animated: true)
            }
            if self.progress >= progress {
                timer.invalidate()
                if let completion = completion {
                    completion()
                }
            }
        }
    }
    
}
