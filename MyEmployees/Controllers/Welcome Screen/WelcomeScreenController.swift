//
//  ViewController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class WelcomeScreenController: UIViewController {
    
    @IBOutlet weak var splashscreenView: SplashscreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        splashscreenView.logoImageView.image = UIImage(named: "ESC Logo")
        splashscreenView.progressView.setAnimatedProgress(duration: 2) {
            self.performSegue(withIdentifier: "welcomeToLogin", sender: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UIApplication.shared.windows.first?.rootViewController = segue.destination
    }
    
    deinit {
        print("WelcomeScreenController deinit called")
    }

}
