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
        textFieldConfig(textField: currentPasswordTextField, placeHolder: "현재 비밀번호")
        
        addSubview(newPasswordTextField)
        textFieldConfig(textField: newPasswordTextField, placeHolder: "새로운 비밀번호")
        
        addSubview(confirmNewPasswordTextField)
        textFieldConfig(textField: confirmNewPasswordTextField, placeHolder: "비밀번호 확인")
        
        addSubview(confirmButton)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.setTitle("변경하기", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        
        self.backgroundColor = .systemBackground
    }
    
    func textFieldConfig(textField: UITextField, placeHolder: String) {
        textField.isSecureTextEntry = true
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        textField.placeholder = placeHolder
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
