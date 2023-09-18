//
//  PostService.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/09/14.
//

import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(caption: String, image: UIImage, user: User, compeltion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUid": uid,
                        
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username ] as [String : Any]
            
            COLLECTION_POST.addDocument(data: data, completion: compeltion)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POST.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictinary: $0.data()) })
            completion(posts)
            
        }
    }
    
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void) {
        let query = COLLECTION_POST.whereField("ownerUid", isEqualTo: uid)
        // order(by: "timestamp", descending: true) 최신 가장 앞에
        
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictinary: $0.data()) })
            completion(posts)
        }
    }
    
}
