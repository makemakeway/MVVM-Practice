//
//  PostDetailFooterView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/06.
//

import UIKit
import SnapKit


class PostDetailFooterView: UIView, ViewRepresentable {
    
    let textField = UITextField()
    
    func setUpView() {
        addSubview(textField)
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "댓글을 입력해주세요."
        textField.backgroundColor = .systemGray3
        
        self.backgroundColor = .systemBackground
    }
    
    func setUpConstraints() {
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
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
