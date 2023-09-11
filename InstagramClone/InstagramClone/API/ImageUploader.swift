//
//  ImageUploader.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/04/19.
//

import FirebaseStorage

// 이미지를 Firebase Storage에 업로드하고 업로드된 이미지의 다운로드 URL을 얻을 수 있습니다.
struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
        
    }
}
