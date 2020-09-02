//
//  CompanyRegistrationController.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class CompanyRegistrationController: UIViewController {
    
    @IBOutlet var companyView: CompanyView!
    
    let logoKey = UUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dismiss(animated: false, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UIApplication.shared.windows.first?.rootViewController = segue.destination
    }
    
    deinit {
        print("CompanyRegistrationController deinit called")
    }
    
}
