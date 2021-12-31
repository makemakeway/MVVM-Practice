//
//  SignInView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit
import SnapKit

class SignInView: UIView, ViewRepresentable {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    let signUpButton = UIButton()
    let logoImageView = UIImageView()
    
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
        emailTextField.isSkeletonable = true
        passwordTextField.isSkeletonable = true
        signInButton.isSkeletonable = true
        signUpButton.isSkeletonable = true
    }
    
    func showSkeletonView() {
        emailTextField.showGradientSkeleton()
        passwordTextField.showGradientSkeleton()
        signInButton.showGradientSkeleton()
        signUpButton.showGradientSkeleton()
    }
    
    func setUpView() {
        addSubview(logoImageView)
        logoImageView.image = UIImage(named: "mappin")
        logoImageView.contentMode = .scaleAspectFill
        addSubview(emailTextField)
        emailTextField.backgroundColor = .white
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.placeholder = "이메일"
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.placeholder = "비밀번호"
        addSubview(signInButton)
        signInButton.backgroundColor = .systemBlue
        signInButton.setTitle("로그인", for: .normal)
        addSubview(signUpButton)
        signUpButton.tintColor = .systemBlue
        signUpButton.setTitle("가입하기", for: .normal)
    }
    
    func setUpConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-40)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(100)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
            make.centerX.equalTo(emailTextField)
        }
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
            make.centerX.equalTo(emailTextField)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(10)
            make.trailing.equalTo(signInButton)
        }
    }
    
}
