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
    let commentLabel = UILabel()
    
    func setUpView() {
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(profileNameLabel)
        self.contentView.addSubview(profileDateLabel)
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(commentView)
        self.contentView.addSubview(commentImage)
        self.contentView.addSubview(commentLabel)
        
        profileImageView.backgroundColor = .systemTeal
        profileImageView.image = UIImage(systemName: "person.fill")
        profileImageView.tintColor = .systemGray
        
        profileNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        profileDateLabel.font = UIFont.systemFont(ofSize: 14)
        profileDateLabel.textColor = .darkGray
        
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        
        commentImage.image = UIImage(systemName: "bubble.left")
        commentImage.tintColor = .darkGray
        
        commentLabel.text = "댓글쓰기"
        commentLabel.font = UIFont.systemFont(ofSize: 15)
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
