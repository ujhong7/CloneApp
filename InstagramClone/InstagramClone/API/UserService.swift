//
//  UserService.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/09/07.
//

import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    // 현재 로그인한 사용자의 정보를 Firebase Firestore에서 가져오는 역할
    static func fetchUser(completion: @escaping(User) -> Void) {
        
        // 현재 로그인한 사용자의 UID(사용자 고유 식별자)를 가져옵니다.
        // Firebase Authentication을 사용하여 현재 사용자가 로그인했는지 확인합니다. 사용자가 로그인하지 않았다면 함수를 종료
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // "users" 컬렉션에서 현재 사용자의 UID를 사용하여 해당 사용자 문서를 가져옴
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            print("DEBUG: Snapshot is \(snapshot?.data())")
            
            // 가져온 문서의 데이터를 가져옵니다. 이 데이터는 키-값 쌍으로 구성
            guard let dictionary = snapshot?.data() else { return }
            
            // 가져온 데이터를 사용하여 User 객체를 생성합니다.
            // User 객체는 사용자 정보를 나타내며, 이를 기반으로 화면에 사용자 정보를 표시할 수 있습니다.
            let user = User(dictinary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({User(dictinary: $0.data())})
            completion(users)
        }
    }
    
    // ⭐️
    static func follow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
            
        }
        
    }
    
    static func unfollow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
        
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument{ (snapshot, error) in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
        
    }
    
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapshot, _) in
            let followers = snapshot?.documents.count ?? 0
            
            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { (snapshot, _) in
                let following = snapshot?.documents.count ?? 0
                
                completion(UserStats(followers: followers, following: following))
                
            }
        }
    }
    
}

// Firebase Firestore에서 현재 로그인한 사용자의 정보를 가져와서 해당 정보를 User 객체로 변환하여 반환합니다.
// 이 정보를 활용하여 사용자 프로필을 표시하거나 다른 작업을 수행할 수 있습니다.


