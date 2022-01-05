//
//  PostDetailHeaderView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/04.
//

import UIKit
import SnapKit

class PostDetailHeaderView: UIView, ViewRepresentable {
    
    let profileImageView = UIImageView()
    let profileNameLabel = UILabel()
    let profileDateLabel = UILabel()
    var contentLabel = UILabel()
    let commentView = UIView()
    let commentImage = UIImageView()
    var commentLabel = UILabel()
    
    func setUpView() {
        self.addSubview(profileImageView)
        self.addSubview(profileNameLabel)
        self.addSubview(profileDateLabel)
        self.addSubview(contentLabel)
        self.addSubview(commentView)
        commentView.addSubview(commentImage)
        commentView.addSubview(commentLabel)
        
        profileImageView.backgroundColor = .systemIndigo
        profileImageView.image = UIImage(systemName: "person.fill")
        profileImageView.tintColor = .lightGray
        
        profileNameLabel.font = UIFont().mainFontBold
        
        profileDateLabel.font = UIFont().smallFontRegular
        profileDateLabel.textColor = .darkGray
        
        contentLabel.font = UIFont().contentFontRegular
        contentLabel.numberOfLines = 0
        
        commentImage.image = UIImage(systemName: "bubble.left")
        commentImage.tintColor = .darkGray
        
        commentLabel.text = "댓글쓰기"
        commentLabel.font = UIFont().mainFontRegular
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
        profileNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(5)
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        profileDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileNameLabel)
            make.top.equalTo(profileNameLabel.snp.bottom).offset(5)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(profileDateLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        commentView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-20)
        }

        commentImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.size.equalTo(20)
            make.centerY.equalToSuperview()
        }

        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(commentImage.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
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
