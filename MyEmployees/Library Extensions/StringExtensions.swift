//
//  Extensions.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 9/2/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation

extension String {

    func sha256(salt: String) -> Data {
        return (self + salt).data(using: .utf8)!.sha256
    }

}
