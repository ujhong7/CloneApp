//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/09/08.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var prrfileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var numOfFollowers: NSAttributedString {
        return attributedStatText(value: user.stats.followers, label: "followers")
    }
    
    var numOfFollowing: NSAttributedString {
        return attributedStatText(value: user.stats.following, label: "following")
    }
    
    var numOfPosts: NSAttributedString {
        return attributedStatText(value: user.stats.posts, label: "posts")
    }
    
    init(user: User) {
        self.user = user
    }

    
    // 정수 값과 레이블 문자열을 받아서 스타일링된 NSAttributedString을 생성하는 메서드
    func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    
}

// 이 ViewModel은 뷰 컨트롤러에서 사용자 프로필 정보를 표시하는 뷰(ProfileHeader)에 데이터를 제공하는 역할을 합니다.
// 따라서 뷰 컨트롤러에서 이 ViewModel을 생성하고 뷰에 연결하여 사용자 프로필 정보를 효과적으로 표시할 수 있습니다.
