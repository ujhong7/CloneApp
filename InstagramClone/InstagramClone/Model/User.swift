//
//  User.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/09/07.
//

import Foundation
import Firebase
 
struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    var isFollowed = false
    
    var stats: UserStats!
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    // 구조체의 초기화(Initialization) 부분에서는 Firebase Firestore에서 가져온 데이터를 기반으로 각 필드를 초기화합니다.
    // init 메서드는 딕셔너리(dictionary)를 입력으로 받아 각 필드를 딕셔너리에서 추출하여 초기화합니다. 
    init(dictinary: [String: Any]) {
        self.email = dictinary["email"] as? String ?? ""
        self.fullname = dictinary["fullname"] as? String ?? ""
        self.profileImageUrl = dictinary["profileImageUrl"] as? String ?? ""
        self.username = dictinary["username"] as? String ?? ""
        self.uid = dictinary["uid"] as? String ?? ""
        
        self.stats = UserStats(followers: 0, following: 0, posts: 0) // default setting
    }
}

struct UserStats {
    let followers: Int
    let following: Int
    let posts: Int
}
