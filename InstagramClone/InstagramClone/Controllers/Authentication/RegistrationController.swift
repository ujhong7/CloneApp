//
//  RegistrationController.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/04/17.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
 
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
    }
    
    
}
