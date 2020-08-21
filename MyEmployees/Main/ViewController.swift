//
//  ViewController.swift
//  MyEmployees
//
//  Created by escience on 8/21/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Thread.sleep(forTimeInterval: 2.0)
        let controller = LoginController()
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: true, completion: nil)
    }

}
