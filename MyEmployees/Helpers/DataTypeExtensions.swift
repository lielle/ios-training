//
//  DataTypeExtensions.swift
//  MyEmployees
//
//  Created by escience on 8/24/20.
//  Copyright © 2020 escience. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {

    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }

    var sha256: Data {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        self.withUnsafeBytes({
            _ = CC_SHA256($0.baseAddress, CC_LONG(self.count), &digest)
        })
        return Data(_: digest)
    }

}

extension String {

    func sha256(salt: String) -> Data {
        return (self + salt).data(using: .utf8)!.sha256
    }

}
