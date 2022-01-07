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
    
    let disposeBag = DisposeBag()
    var viewModel: PostDetailViewModel
    
    //MARK: UI
    let mainView = EditCommentView()
    
    
    //MARK: Method
    
    func bind() {
        mainView.textField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self](_) in
                guard let self = self else { return }
                print("댓글 수정")
                self.dismiss(animated: true, completion: nil)
            }
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
    
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("===Edit Comment VC Deinit===")
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = PostDetailViewModel(element: BoardElement(id: 0, text: "", user: User(id: 0, username: "", email: "", provider: "", confirmed: true, blocked: true, role: 0, createdAt: "", updatedAt: ""), createdAt: "", updatedAt: "", comments: []))
        super.init(coder: coder)
    }
}
