//
//  LoginController.swift
//  InstagramClone
//
//  Created by yujaehong on 2023/04/17.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    // CustomTextField 
    private let emailTextField: UITextField  = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField  = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false // ⭐️viewModel.formIsValid
        return button
    }()
    
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        // setAttributedTitle ⭐️ (Extensions파일)
        button.attributedTitle(firstPart: "Don't have an account? ", secondPart: "Sign Up")
        
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.attributedTitle(firstPart: "Forgot your password? ", secondPart: "Get help signing in.")
        
        return button
    }()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        configureUI()
        configureNotificationObserver()
    }
    
    // MARK: - Actions
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // ⭐️ id,password 텍스트필드 모두 입력되었을때 login버튼 활성화
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
         
        updateForm()
        
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer() // backgroundColor 그라데이션 (Extensionv 파일)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    } 
    
    
    func configureNotificationObserver() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}


extension LoginController: FormViewModel {
    // ⭐️
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor((viewModel.buttonTitleColor), for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
    
    
}
