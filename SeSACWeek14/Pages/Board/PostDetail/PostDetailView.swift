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
    
    func setUpView() {
        addSubview(tableView)
        tableView.register(PostDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: PostDetailHeaderView.reuseIdentifier)
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
    }
    
    func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
