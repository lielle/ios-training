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
        setupViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    deinit {
        print("WelcomeScreenController deinit called")
    }
    
    func setupViews() {
        splashscreenView.logoImageView.image = UIImage(named: "ESC Logo")
        splashscreenView.progressView.setAnimatedProgress(duration: 2) {
            if CompanyDao.getLoggedIn() != nil {
                self.performSegue(withIdentifier: "welcomeToMain", sender: nil)
            } else {
                self.performSegue(withIdentifier: "welcomeToLogin", sender: nil)
            }
        }
    }

}
