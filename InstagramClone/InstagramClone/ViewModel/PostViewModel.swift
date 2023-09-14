//
//  PostViewModel.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/09/14.
//

import Foundation

struct PostViewModel {
    private let post: Post
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: Int {
        return post.likes
        
    }
    
    init(post: Post) {
        self.post = post
    }
    
}
