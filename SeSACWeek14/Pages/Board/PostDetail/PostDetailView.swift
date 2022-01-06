//
//  PostDetailView.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/04.
//

import UIKit
import SnapKit

class PostDetailView: UIView, ViewRepresentable {
    let tableView = UITableView()
    let headerView = PostDetailHeaderView()
    let footerView = PostDetailFooterView()
    
    func setUpView() {
        addSubview(tableView)
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
        tableView.tableHeaderView = headerView
        addSubview(footerView)
        self.backgroundColor = .systemBackground
    }
    
    func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-60)
        }
        
        footerView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview()
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
