//
//  SignInView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit
import SnapKit

class SignInView: UIView, ViewRepresentable {
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    let signUpButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
        setSkeletonView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setSkeletonView() {
        usernameTextField.isSkeletonable = true
        passwordTextField.isSkeletonable = true
        signInButton.isSkeletonable = true
        signUpButton.isSkeletonable = true
    }
    
    func showSkeletonView() {
        usernameTextField.showGradientSkeleton()
        passwordTextField.showGradientSkeleton()
        signInButton.showGradientSkeleton()
        signUpButton.showGradientSkeleton()
    }
    
    func setUpView() {
        addSubview(usernameTextField)
        usernameTextField.backgroundColor = .white
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
        addSubview(signInButton)
        signInButton.backgroundColor = .systemBlue
        signInButton.setTitle("Sign In", for: .normal)
        addSubview(signUpButton)
        signUpButton.tintColor = .systemBlue
        signUpButton.setTitle("Sign up", for: .normal)
    }
    
    func setUpConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
            make.centerX.equalTo(usernameTextField)
        }
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
            make.centerX.equalTo(usernameTextField)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(10)
            make.trailing.equalTo(signInButton)
        }
    }
    
}
