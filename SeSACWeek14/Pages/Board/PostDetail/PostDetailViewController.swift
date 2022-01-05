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
                self?.mainView.headerView.contentLabel.text = element.text
                self?.mainView.headerView.commentLabel.text = "댓글 \(element.comments.count)"
                self?.mainView.headerView.profileNameLabel.text = element.user.username
                
                let date = DateManager.shared.stringToDate(string: element.updatedAt)
                let dateString = DateManager.shared.dateToString(date: date)
                
                self?.mainView.headerView.profileDateLabel.text = dateString
                
            }
            .disposed(by: disposeBag)
        
        viewModel.commentsObservable
            .bind(to: mainView.tableView.rx.items(cellIdentifier: CommentTableViewCell.reuseIdentifier, cellType: CommentTableViewCell.self)) { (row, element, cell) in
                cell.usernameLabel.text = "\(element.user.username)"
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
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let headerView = mainView.tableView.tableHeaderView {

            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame

            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                mainView.tableView.tableHeaderView = headerView
            }
        }
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
