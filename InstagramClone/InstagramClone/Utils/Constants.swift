//
//  Constants.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/09/07.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POST = Firestore.firestore().collection("posts")

// Firestore 데이터베이스에서 "users"라는 컬렉션을 참조합니다.
// Firestore는 데이터를 컬렉션 안에 문서(document)로 구조화합니다.
// "users" 컬렉션은 사용자 데이터를 저장하기 위한 컬렉션으로, 앱의 사용자 정보가 여기에 저장될 것입니다.
