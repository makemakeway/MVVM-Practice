//
//  PostDetailViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/04.
//

import UIKit
import RxCocoa
import RxSwift

class PostDetailViewController: UIViewController {
    //MARK: Properties
    
    var viewModel: PostDetailViewModel
    
    let disposeBag = DisposeBag()
    
    //MARK: UI
    let mainView = PostDetailView()
    
    
    //MARK: Method
    func bind() {
        
        viewModel.boardElement
            .bind { [weak self](element) in
                let headerView = self?.mainView.tableView.headerView(forSection: 0) as! PostDetailHeaderView
                
                headerView.commentLabel.text = "댓글 \(element.comments)"
                headerView.contentLabel.text = element.text
            }
            .disposed(by: disposeBag)
        
        viewModel.commentsObservable
            .bind(to: mainView.tableView.rx.items(cellIdentifier: CommentTableViewCell.reuseIdentifier, cellType: CommentTableViewCell.self)) { (row, element, cell) in
                cell.usernameLabel.text = "\(element.user)"
                cell.commentContentLabel.text = element.comment
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: LifeCycle
    init(element: BoardElement) {
        self.viewModel = PostDetailViewModel(element: element)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        bind()
    }
    
    required init?(coder: NSCoder) {
        viewModel = PostDetailViewModel(element: BoardElement(id: 0,
                                                              text: "",
                                                              user: User(id: 0, username: "", email: "", provider: "", confirmed: false, blocked: false, role: 1, createdAt: "", updatedAt: ""),
                                                              createdAt: "",
                                                              updatedAt: "",
                                                              comments: []))
        super.init(coder: coder)
    }
}

extension PostDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostDetailHeaderView.reuseIdentifier)!
        return header
    }
}
