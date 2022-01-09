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
    
    let navBar = UINavigationBar()
    
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
        
        addSubview(navBar)
        
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = .black
        
        confirmButton.setTitle("완료", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        
        let navTitle = UINavigationItem(title: "새싹농장 글쓰기")
        let leftButton = UIBarButtonItem(customView: xButton)
        let rightButton = UIBarButtonItem(customView: confirmButton)
        
        navBar.setItems([navTitle], animated: true)
        navBar.topItem?.leftBarButtonItem = leftButton
        navBar.topItem?.rightBarButtonItem = rightButton
    }
    
    func setUpConstraints() {
        navBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        xButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }

        confirmButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
        }
    }
    
    
}
