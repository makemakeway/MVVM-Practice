//
//  EditPostView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/03.
//

import UIKit
import SnapKit

class EditPostView: UIView, ViewRepresentable {
    
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
    }
    
    func setUpConstraints() {
        textView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
}
