//
//  Functions.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/25/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func getImage(name: String) -> UIImage? {
    let filename = getDocumentsDirectory().appendingPathComponent("\(name).\(JPEG_EXTENSION)")
    let image = UIImage(contentsOfFile: filename.path)
    
    return image
}

