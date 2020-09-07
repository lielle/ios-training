//
//  Functions.swift
//  MyEmployees
//
//  Created by Lielle Bawar on 8/25/20.
//  Copyright © 2020 escience. All rights reserved.
//

import UIKit

struct FileHelper {

    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    static func getImage(named name: String) -> UIImage? {
        let filename = getDocumentsDirectory().appendingPathComponent("\(name).\(JPEG_EXTENSION)")
        let data = NSData(contentsOfFile: filename.path)
        let image = UIImage(data: data! as Data)
        
        return image
    }

    static func saveImage(_ image: UIImage?, named name: String) {
        guard let image = image else {
            print("Save image failed. No image found.")
            return
        }
        if let data = image.jpegData(compressionQuality: 1.0) {
            let filename = getDocumentsDirectory().appendingPathComponent("\(name).\(JPEG_EXTENSION)")
            try? data.write(to: filename)
        }
    }

    static func deleteImage(named name: String) {
        let fileManager = FileManager.default
        let path = getDocumentsDirectory().appendingPathComponent("\(name).\(JPEG_EXTENSION)").path
        if fileManager.fileExists(atPath: path) {
            try? fileManager.removeItem(atPath: path)
        } else {
            print("Image does not exist")
        }
    }

    static func replaceImage(named name: String, to image: UIImage) {
        deleteImage(named: name)
        saveImage(image, named: name)
    }
    
}
