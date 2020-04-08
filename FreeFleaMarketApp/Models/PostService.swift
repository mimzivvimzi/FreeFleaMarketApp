//
//  PostService.swift
//  FreeFleaMarketApp
//
//  Created by Michelle Lau on 2020/04/08.
//  Copyright © 2020 Michelle Lau. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    static func create(for image: UIImage) {
        let imageRef = Storage.storage().reference().child("test_image.jpg")
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }

            let urlString = downloadURL.absoluteString
            print("image url: \(urlString)")
        }
    }
}

