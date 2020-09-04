//
//  SplashscreenController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class SplashscreenController: UIViewController {
    
    @IBOutlet var splashscreenView: SplashscreenView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let company = CompanyDao.getLoggedIn() else {
            return
        }
        splashscreenView.logoImageView.image = getImage(named: company.logoKey!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        splashscreenView.progressView.setAnimatedProgress(duration: 5) {
            self.performSegue(withIdentifier: "splashToMain", sender: nil)
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
        print("SplashscreenController deinit called")
    }

}
