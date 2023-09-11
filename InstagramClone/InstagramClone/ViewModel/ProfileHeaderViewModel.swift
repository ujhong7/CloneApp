//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/09/08.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var prrfileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {
        self.user = user
    }
}

// 이 ViewModel은 뷰 컨트롤러에서 사용자 프로필 정보를 표시하는 뷰(ProfileHeader)에 데이터를 제공하는 역할을 합니다.
// 따라서 뷰 컨트롤러에서 이 ViewModel을 생성하고 뷰에 연결하여 사용자 프로필 정보를 효과적으로 표시할 수 있습니다.
