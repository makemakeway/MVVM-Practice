//
//  BoardView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/29.
//

import UIKit
import SnapKit

class BoardView: UIView, ViewRepresentable {
    
    let tableView = UITableView()
    let addPostButton = UIButton()
    let changePasswordButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setUpView() {
        addSubview(tableView)
        addSubview(addPostButton)
        addPostButton.backgroundColor = .systemIndigo
        addPostButton.tintColor = .white
        addPostButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addPostButton.layer.cornerRadius = 22
        
        changePasswordButton.tintColor = .label
        changePasswordButton.setImage(UIImage(systemName: "person"), for: .normal)
    }
    
    func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addPostButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(44)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
    }
    
    
}
