//
//  SignUpView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit
import SkeletonView

class SignUpView: UIView, ViewRepresentable {
    let logoImageView = UIImageView()
    let emailTextField = UITextField()
    var usernameTextField = UITextField()
    var passwordTextField = UITextField()
    var confirmTextField = UITextField()
    var signUpButton = UIButton()
    
    func setSkeletonView() {
        emailTextField.isSkeletonable = true
        usernameTextField.isSkeletonable = true
        passwordTextField.isSkeletonable = true
        confirmTextField.isSkeletonable = true
        signUpButton.isSkeletonable = true
    }
    
    func showSkeletonView() {
        emailTextField.showGradientSkeleton()
        usernameTextField.showGradientSkeleton()
        passwordTextField.showGradientSkeleton()
        confirmTextField.showGradientSkeleton()
        signUpButton.showGradientSkeleton()
    }
    
    func hideSkeletonView() {
        emailTextField.hideSkeleton()
        usernameTextField.hideSkeleton()
        passwordTextField.hideSkeleton()
        confirmTextField.hideSkeleton()
        signUpButton.hideSkeleton()
    }
    
    func setUpView() {
        addSubview(logoImageView)
        logoImageView.image = UIImage(named: "mappin")
        logoImageView.contentMode = .scaleAspectFill
        
        addSubview(emailTextField)
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "이메일 주소"
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        
        addSubview(usernameTextField)
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "아이디"
        usernameTextField.autocapitalizationType = .none
        usernameTextField.autocorrectionType = .no
        
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.isSecureTextEntry = true
        
        addSubview(confirmTextField)
        confirmTextField.backgroundColor = .white
        confirmTextField.placeholder = "비밀번호 확인"
        confirmTextField.isSecureTextEntry = true
        
        addSubview(signUpButton)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.setTitle("가입하기", for: .normal)
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
        
        logoImageView.snp.makeConstraints { make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-40)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(100)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.height.equalTo(usernameTextField)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        confirmTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.height.equalTo(usernameTextField)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(confirmTextField.snp.bottom).offset(20)
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
