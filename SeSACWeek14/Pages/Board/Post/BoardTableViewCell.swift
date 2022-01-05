//
//  BoardTableViewCell.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/31.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    let usernameLabel = UILabel()
    let contentLabel = UILabel()
    let dateLabel = UILabel()
    let commentView = UIView()
    let commentImage = UIImageView()
    let commentLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpView() {
        contentView.addSubview(usernameLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(commentView)
        commentView.addSubview(commentImage)
        commentView.addSubview(commentLabel)
        
        usernameLabel.textColor = .darkGray
        usernameLabel.font = UIFont.systemFont(ofSize: 15)
        
        contentLabel.numberOfLines = 3
        
        dateLabel.textColor = .darkGray
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        
        commentImage.image = UIImage(systemName: "bubble.left")
        commentImage.tintColor = .darkGray
        
        commentLabel.text = "댓글쓰기"
        commentLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    func setConstraints() {
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(contentLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        commentView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        commentImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
        }

        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(commentImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
