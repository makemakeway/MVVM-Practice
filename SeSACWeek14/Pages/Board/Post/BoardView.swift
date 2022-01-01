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
    }
    
    func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
