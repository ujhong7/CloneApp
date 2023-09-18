//
//  Post.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/09/14.
//

import Firebase

struct Post {
    let caption: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timestamp: Timestamp
    let postId: String
    
    let ownerImageUrl: String
    let ownerUsername: String
    
    init(postId: String, dictinary: [String: Any]) {
        self.postId = postId
        self.caption = dictinary["caption"] as? String ?? ""
        self.likes = dictinary["likes"] as? Int ?? 0
        self.imageUrl = dictinary["imageUrl"] as? String ?? ""
        self.timestamp = dictinary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerUid = dictinary["ownerUid"] as? String ?? ""
        
        self.ownerImageUrl = dictinary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictinary["ownerUsername"] as? String ?? ""
    }
    
    // 섹션 8. 36 Post User Data
}
