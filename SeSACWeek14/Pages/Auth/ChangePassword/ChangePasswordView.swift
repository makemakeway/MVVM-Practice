//
//  ChangePasswordView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/02.
//

import UIKit
import SnapKit

class ChangePasswordView: UIView, ViewRepresentable {
    
    let currentPasswordTextField = UITextField()
    let newPasswordTextField = UITextField()
    let confirmNewPasswordTextField = UITextField()
    let confirmButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpView() {
        addSubview(currentPasswordTextField)
        currentPasswordTextField.isSecureTextEntry = true
        currentPasswordTextField.autocorrectionType = .no
        currentPasswordTextField.autocapitalizationType = .none
        currentPasswordTextField.backgroundColor = .white
        currentPasswordTextField.placeholder = "현재 비밀번호"
        
        addSubview(newPasswordTextField)
        newPasswordTextField.isSecureTextEntry = true
        newPasswordTextField.autocorrectionType = .no
        newPasswordTextField.autocapitalizationType = .none
        newPasswordTextField.backgroundColor = .white
        newPasswordTextField.placeholder = "새로운 비밀번호"
        
        addSubview(confirmNewPasswordTextField)
        confirmNewPasswordTextField.isSecureTextEntry = true
        confirmNewPasswordTextField.autocorrectionType = .no
        confirmNewPasswordTextField.autocapitalizationType = .none
        confirmNewPasswordTextField.backgroundColor = .white
        confirmNewPasswordTextField.placeholder = "비밀번호 확인"
        
        addSubview(confirmButton)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.setTitle("변경하기", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
    }
    
    func setUpConstraints() {
        newPasswordTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
        currentPasswordTextField.snp.makeConstraints { make in
            make.bottom.equalTo(newPasswordTextField.snp.top).offset(-20)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
            make.centerX.equalTo(newPasswordTextField)
        }
        confirmNewPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
            make.centerX.equalTo(newPasswordTextField)
        }
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(confirmNewPasswordTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
            make.centerX.equalTo(newPasswordTextField)
        }
    }
}
