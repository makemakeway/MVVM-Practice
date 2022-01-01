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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpView() {
        contentView.addSubview(contentLabel)
    }
    
    func setConstraints() {
        contentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.bottom.trailing.equalToSuperview().offset(-20)
        }
    }
}
