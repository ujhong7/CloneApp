//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/09/07.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    // MARK: - Porperties
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "venom-7")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
        
    // MARK: - LifeCycle
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
