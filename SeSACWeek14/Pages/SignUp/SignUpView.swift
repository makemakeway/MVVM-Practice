//
//  SignUpView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit

class SignUpView: UIView, ViewRepresentable {
    var usernameTextField = UITextField()
    var passwordTextField = UITextField()
    var signUpButton = UIButton()
    
    
    func setUpView() {
        addSubview(usernameTextField)
        usernameTextField.backgroundColor = .white
        addSubview(passwordTextField)
        passwordTextField.backgroundColor = .white
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
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.height.equalTo(usernameTextField)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.height.equalTo(usernameTextField)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
