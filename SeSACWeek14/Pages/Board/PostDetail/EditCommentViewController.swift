//
//  EditCommentViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/06.
//

import UIKit
import RxSwift
import RxCocoa

class EditCommentViewController: UIViewController {
    //MARK: Properties
    
    var disposeBag = DisposeBag()
    var viewModel: PostDetailViewModel
    var element: CommentDetail
    
    //MARK: UI
    let mainView = EditCommentView()
    
    
    //MARK: Method
    
    func bind() {
        mainView.textField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self](_) in
                guard let self = self else { return }
                print("댓글 수정")
                self.viewModel.editComment(commentId: self.element.id, postId: self.element.post.id) { (error) in
                    guard let error = error else {
                        return
                    }
                    self.APIErrorHandler(error: error, message: "댓글 수정에 실패했습니다.")
                }
                self.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        mainView.textField.rx.text.orEmpty
            .bind(to: viewModel.editCommentText)
            .disposed(by: disposeBag)
    }
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.textField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    init(viewModel: PostDetailViewModel, element: CommentDetail) {
        self.viewModel = viewModel
        self.element = element
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("===Edit Comment VC Deinit===")
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = PostDetailViewModel(element: BoardElement(id: 0, text: "", user: User(id: 0, username: "", email: "", provider: "", confirmed: true, blocked: true, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
        self.element = CommentDetail(id: 0, comment: "", user: User(id: 0, username: "", email: "", provider: "", confirmed: true, blocked: true, role: 0, createdAt: "", updatedAt: ""), post: Post(id: 0, text: "", user: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "")
        super.init(coder: coder)
    }
}
