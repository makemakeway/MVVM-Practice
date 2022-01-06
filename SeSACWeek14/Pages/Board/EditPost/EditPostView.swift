//
//  EditPostView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/03.
//

import UIKit
import SnapKit

class EditPostView: UIView, ViewRepresentable {
    
    let navigationBar = UIView()
    let xButton = UIButton()
    let titleLabel = UILabel()
    let confirmButton = UIButton()
    let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpView() {
        self.backgroundColor = .systemBackground
        addSubview(textView)
        textView.font = UIFont.systemFont(ofSize: 18)
        
        addSubview(navigationBar)
        navigationBar.addSubview(xButton)
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = .black
        navigationBar.addSubview(titleLabel)
        titleLabel.text = "새싹농장 글쓰기"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationBar.addSubview(confirmButton)
        
        let title = NSAttributedString(string: "완료", attributes: [.font:UIFont.systemFont(ofSize: 18, weight: .semibold), .foregroundColor:UIColor.black])
        confirmButton.setAttributedTitle(title, for: .normal)
        
    }
    
    func setUpConstraints() {
        navigationBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        xButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(44)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(44)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
}
