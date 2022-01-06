//
//  EditCommentView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/06.
//

import UIKit
import SnapKit

class EditCommentView: UIView, ViewRepresentable {
    
    let textField = UITextField()
    let textFieldView = UIView()
    
    func setUpView() {
        addSubview(textFieldView)
        textFieldView.addSubview(textField)
        textFieldView.backgroundColor = .white
        textFieldView.layer.cornerRadius = 10
        
        textField.placeholder = "수정할 내용을 입력해주세요."
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray5
    }
    
    func setUpConstraints() {
        textFieldView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().dividedBy(1.25)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(44)
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
