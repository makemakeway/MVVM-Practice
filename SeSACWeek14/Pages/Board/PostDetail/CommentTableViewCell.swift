//
//  CommentTableViewCell.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/05.
//

import UIKit
import SnapKit

class CommentTableViewCell: UITableViewCell, ViewRepresentable {
    
    let usernameLabel = UILabel()
    let commentContentLabel = UILabel()
    let commentInfoButton = UIButton()
    
    func setUpView() {
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(commentContentLabel)
        self.contentView.addSubview(commentInfoButton)
        
        usernameLabel.font = UIFont().mainFontBold
        
        commentContentLabel.font = UIFont().contentFontRegular
        commentContentLabel.numberOfLines = 0
        
        commentInfoButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        commentInfoButton.transform = commentInfoButton.transform.rotated(by: .pi / 2)
        commentInfoButton.tintColor = .darkGray
    }
    
    func setUpConstraints() {
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(10)
        }
        
        commentContentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        commentInfoButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(usernameLabel.snp.bottom)
            make.size.equalTo(20)
        }
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
