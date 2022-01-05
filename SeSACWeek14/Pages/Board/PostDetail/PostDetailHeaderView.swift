//
//  PostDetailHeaderView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/04.
//

import UIKit
import SnapKit

class PostDetailHeaderView: UITableViewHeaderFooterView, ReusableView, ViewRepresentable {
    
    let profileImageView = UIImageView()
    let profileNameLabel = UILabel()
    let profileDateLabel = UILabel()
    let contentLabel = UILabel()
    let commentView = UIView()
    let commentImage = UIImageView()
    var commentLabel = UILabel()
    
    func setUpView() {
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(profileNameLabel)
        self.contentView.addSubview(profileDateLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(commentView)
        commentView.addSubview(commentImage)
        commentView.addSubview(commentLabel)
        
        profileImageView.backgroundColor = .systemTeal
        profileImageView.image = UIImage(systemName: "person.fill")
        profileImageView.tintColor = .systemGray
        
        profileNameLabel.font = UIFont().mainFontBold
        
        profileDateLabel.font = UIFont().smallFontRegular
        profileDateLabel.textColor = .darkGray
        
        contentLabel.font = UIFont().contentFontRegular
        contentLabel.numberOfLines = 0
        
        commentImage.image = UIImage(systemName: "bubble.left")
        commentImage.tintColor = .darkGray
        
        commentLabel.text = "댓글쓰기"
        commentLabel.font = UIFont().mainFontRegular
        
        profileNameLabel.text = "zzzzz"
        profileDateLabel.text = "12/01"
        contentLabel.text = "zzfsdl,fds;fdsl;f,sl;df,dsl;f,sdf;lsd,fl"
        
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
            make.bottom.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
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
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}
