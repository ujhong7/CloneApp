//
//  CustomTextField.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/04/17.
//

import UIKit

// LoginController 텍스트필드 (email, password) 
class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        // 텍스트필드 place holder 앞칸 띄기
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
