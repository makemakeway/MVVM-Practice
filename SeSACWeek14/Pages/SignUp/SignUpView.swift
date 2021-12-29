//
//  SignUpView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit
import SkeletonView

class SignUpView: UIView, ViewRepresentable {
    let emailTextField = UITextField()
    var usernameTextField = UITextField()
    var passwordTextField = UITextField()
    var signUpButton = UIButton()
    
    func setSkeletonView() {
        emailTextField.isSkeletonable = true
        usernameTextField.isSkeletonable = true
        passwordTextField.isSkeletonable = true
        signUpButton.isSkeletonable = true
    }
    
    func showSkeletonView() {
        emailTextField.showGradientSkeleton()
        usernameTextField.showGradientSkeleton()
        passwordTextField.showGradientSkeleton()
        signUpButton.showGradientSkeleton()
    }
    
    func hideSkeletonView() {
        emailTextField.hideSkeleton()
        usernameTextField.hideSkeleton()
        passwordTextField.hideSkeleton()
        signUpButton.hideSkeleton()
    }
    
    func setUpView() {
        addSubview(emailTextField)
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "email"
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        
        addSubview(usernameTextField)
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "name"
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "password"
        passwordTextField.isSecureTextEntry = true
        
        addSubview(signUpButton)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.setTitle("Sign Up", for: .normal)
    }
    
    func setUpConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalTo(usernameTextField.snp.top).offset(-20)
            make.centerX.height.equalTo(usernameTextField)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.height.equalTo(usernameTextField)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.height.equalTo(usernameTextField)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
        setSkeletonView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
