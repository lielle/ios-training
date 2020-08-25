//
//  SplashscreenController.swift
//  MyEmployees
//
//  Created by escience on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class SplashscreenController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    private let userPreferences = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let company = userPreferences.value(Company.self, forKey: "company") else {
            return
        }
        
        logoImageView.image = getImage(name: company.logoKey!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.progressView.setAnimatedProgress(duration: 5) {
            let controller = LoginController()
            controller.modalPresentationStyle = .overCurrentContext
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }

}
