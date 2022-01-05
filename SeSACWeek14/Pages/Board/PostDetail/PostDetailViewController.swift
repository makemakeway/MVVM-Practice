//
//  PostDetailViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/04.
//

import UIKit

class PostDetailViewController: UIViewController {
    //MARK: Properties
    var boardElement: BoardElement?
    
    
    //MARK: UI
    let mainView = PostDetailView()
    
    
    //MARK: Method
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
    }
}

extension PostDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostDetailHeaderView.reuseIdentifier)!
        return header
    }
}
