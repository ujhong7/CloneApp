//
//  AuthService.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/04/19.
//


import UIKit
import Firebase


struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    // 로그인
    static func logUserIn(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        // Auth.auth().signIn 사용자 인증
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    // 회원가입
    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            // Auth.auth().createUser 사용자 등록
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                
                if let error = error {
                    print("DEBUG: Failed to register user \(error.localizedDescription)")
                }
                
                guard let uid = result?.user.uid else { return }
 
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "profileImageUrl": imageUrl,
                                           "uid": uid,
                                           "username": credentials.username]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
        
    }
}
