//
//  PostDetailViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/04.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

class PostDetailViewController: UIViewController {
    //MARK: Properties
    
    var viewModel: PostDetailViewModel
    
    var disposeBag = DisposeBag()
    
    //MARK: UI
    let mainView = PostDetailView()
    let refreshControl = UIRefreshControl()
    
    
    //MARK: Method
    func bind() {
        viewModel.deleteObservable
            .subscribe { [weak self](error) in
                guard let self = self else { return }
                guard let error = error.element, let error = error else {
                    print("삭제 완료 됐을 때")
                    self.view.makeToast("포스트가 삭제되었습니다.")
                    self.pushDataAtPreviousVC()
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                print("삭제 실패 후 에러 핸들링")
                self.APIErrorHandler(error: error, message: "포스트 삭제에 실패했습니다.")
            }
            .disposed(by: disposeBag)
        
        viewModel.boardElement
            .bind { [weak self](element) in
                guard let self = self else { return }
                print(element)
                self.mainView.headerView.contentLabel.text = element.text
                self.mainView.headerView.commentLabel.text = "댓글 \(element.comments.count)"
                self.mainView.headerView.profileNameLabel.text = element.user.username
                
                let date = DateManager.shared.stringToDate(string: element.createdAt)
                let dateString = DateManager.shared.dateToString(date: date)
                
                self.mainView.headerView.profileDateLabel.text = dateString
            }
            .disposed(by: disposeBag)
        
        viewModel.commentsObservable
            .bind(to: mainView.tableView.rx.items(cellIdentifier: CommentTableViewCell.reuseIdentifier, cellType: CommentTableViewCell.self)) { (row, element, cell) in
                cell.usernameLabel.text = "\(element.user.username)"
                cell.commentContentLabel.text = element.comment
                cell.selectionStyle = .none
                cell.commentInfoButton.rx.tap
                    .bind { [weak self](_) in
                        guard let self = self else { return }
                        if self.isCurrentUser(element: element) {
                            print("내 댓글")
                            self.makeActionSheet { [weak self](_) in
                                guard let self = self else { return }
                                print("수정")
                                let vc = EditCommentViewController(viewModel: self.viewModel, element: element)
                                self.present(vc, animated: true, completion: nil)
                            } secondHandler: { [weak self](_) in
                                guard let self = self else { return }
                                self.deleteAlert(title: "삭제", message: "댓글을 정말 삭제하시겠어요?", buttonTitle: "삭제") { [weak self](_) in
                                    guard let self = self else { return }
                                    print("삭제")
                                    self.viewModel.deleteComment(commentId: element.id, postId: element.post.id) { [weak self](error) in
                                        guard let self = self else { return }
                                        guard let error = error else {
                                            return
                                        }
                                        self.APIErrorHandler(error: error, message: "댓글 삭제에 실패했습니다.")
                                    }
                                }
                            }
                        } else {
                            self.view.makeToast("사용자의 댓글이 아닙니다.")
                        }
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        viewModel.fetchCommentErrorObservable
            .subscribe { [weak self]error in
                guard let error = error.element else {
                    return
                }
                self?.APIErrorHandler(error: error, message: "정보 받아오기에 실패했습니다.")
            }
            .disposed(by: disposeBag)
        
        viewModel.fetchPostObservable
            .subscribe { [weak self](error) in
                guard let error = error.element else { return }
                self?.APIErrorHandler(error: error, message: "포스트 받아오기에 실패했습니다.")
            }
            .disposed(by: disposeBag)
        
        mainView.footerView.textField.rx.text.orEmpty
            .bind(to: viewModel.commentText)
            .disposed(by: disposeBag)
        
        mainView.footerView.textField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self](_) in
                guard let self = self else { return }
                if self.textFieldIsEmpty() {
                    self.makeAlert(title: "오류", message: "댓글을 입력해주세요.", buttonTitle: "확인", completion: nil)
                    return
                }
                self.viewModel.postComment(completion: { [weak self](error) in
                    guard let self = self else { return }
                    if let error = error {
                        self.APIErrorHandler(error: error, message: "댓글 추가에 실패했습니다.")
                    }
                    self.mainView.footerView.textField.text = ""
                    self.viewModel.fetchPost()
                    self.viewModel.fetchComment() { [weak self] in
                        guard let self = self else { return }
                        self.mainView.tableView.scrollToRow(at: IndexPath(row: self.viewModel.boardElement.value.comments.count - 1, section: 0), at: .bottom, animated: true)
                    }
                    return
                })
            }
            .disposed(by: disposeBag)
        
        mainView.tableView.refreshControl = refreshControl
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.fetchPost()
                self.viewModel.fetchComment()
                
                self.mainView.tableView.refreshControl?.endRefreshing()
            }) 
            .disposed(by: disposeBag)

    }
    
    func isCurrentUser(element: CommentDetail) -> Bool {
        let currentUserId = UserDefaults.standard.integer(forKey: "id")
        print("CURRENT USER: \(currentUserId)")
        let currentCommentUserId = element.user.id
        print("COMMENT USER: \(currentCommentUserId)")
        let isCurrentUser = currentUserId == currentCommentUserId ? true : false
        return isCurrentUser
    }
    
    func makeActionSheet(firstHandler: ((UIAlertAction) -> Void)?, secondHandler: ((UIAlertAction) -> Void)?) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editComment = UIAlertAction(title: "댓글 수정", style: .default, handler: firstHandler)
        let deleteComment = UIAlertAction(title: "댓글 삭제", style: .default, handler: secondHandler)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [editComment, deleteComment, cancel].forEach {
            actionSheet.addAction($0)
        }
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func textFieldIsEmpty() -> Bool {
        return self.mainView.footerView.textField.text!.isEmpty
    }
            
    func pushDataAtPreviousVC() {
        let i = self.navigationController?.viewControllers.firstIndex(of: self)
        let previousViewController = self.navigationController?.viewControllers[i!-1] as! MainViewController
        previousViewController.viewModel.fetchBoard(start: 1, limit: 10)
    }
    
    func navigationBarConfig() {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .darkGray
        button.transform = button.transform.rotated(by: .pi / 2)
        button.addTarget(self, action: #selector(detailButtonClicked(_:)), for: .touchUpInside)
        
        let detailButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.setRightBarButtonItems([detailButton], animated: false)
    }
    
    func presentActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let edit = UIAlertAction(title: "포스트 수정", style: .default) { [weak self](_) in
            guard let self = self else { return }
            let vc = EditPostViewController()
            let text = self.viewModel.boardElement.value.text
            vc.mainView.textView.text = text
            vc.editCase = .edit
            vc.viewModel.postId = self.viewModel.boardElement.value.id
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
        let delete = UIAlertAction(title: "포스트 삭제", style: .destructive) { [weak self](_) in
            self?.deleteAlert(title: "포스트 삭제", message: "포스트를 정말 삭제하시겠어요?", buttonTitle: "삭제") { [weak self](_) in
                print("삭제하기")
                self?.viewModel.deletePost()
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func isYourPost() -> Bool {
        let currentUserId = UserDefaults.standard.integer(forKey: "id")
        let currentPostUserId = viewModel.boardElement.value.user.id
        let result = currentUserId == currentPostUserId ? true : false
        return result
    }
    
    @objc func detailButtonClicked(_ sender: UIBarButtonItem) {
        print("click")
        if isYourPost() {
            presentActionSheet()
        } else {
            self.view.makeToast("사용자의 포스트가 아닙니다.")
        }
    }
    
    //MARK: LifeCycle
    deinit {
        print("===DetailView Deinit===")
    }
    
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
        navigationBarConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag = DisposeBag()
        print("disappear")
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


extension PostDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainView.footerView.textField.resignFirstResponder()
    }
}
