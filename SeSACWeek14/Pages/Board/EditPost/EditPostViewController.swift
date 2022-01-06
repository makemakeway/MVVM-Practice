//
//  EditPostViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa

enum EditCase {
    case add
    case edit
}

class EditPostViewController: UIViewController {
    //MARK: Properties
    
    let viewModel = EditViewModel()
    let disposeBag = DisposeBag()
    var editCase: EditCase = .add
    
    //MARK: UI
    let mainView = EditPostView()
    
    
    //MARK: Method
    
    func bind() {
        mainView.textView.rx.text.orEmpty
            .bind(to: viewModel.textContent)
            .disposed(by: disposeBag)
        
        mainView.xButton.rx.tap
            .bind { [weak self](_) in
                print("tap")
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        mainView.confirmButton.rx.tap
            .bind { [weak self](_) in
                print("tap")
                switch self?.editCase {
                case .add:
                    self?.viewModel.postTextContent()
                case .edit:
                    self?.viewModel.editPostContent()
                case .none:
                    print("에러")
                }
            }
            .disposed(by: disposeBag)

        viewModel.tap
            .subscribe { _ in
                
            } onError: { error in
                let error = error as? APIError
                print("포스트 작성 실패 핸들링")
            } onCompleted: { [weak self] in
                print("포스트 작성 완료")
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.element
            .subscribe { [weak self](element) in
                self?.dataPushAtPresentingVC(element: element)
            }
            .disposed(by: disposeBag)
    }
    
    func dataPushAtPresentingVC(element: BoardElement) {
        switch editCase {
        case .add:
            let nav = self.presentingViewController as! UINavigationController
            let preVC = nav.topViewController as! MainViewController
            preVC.viewModel.fetchBoard()
        case .edit:
            let nav = self.presentingViewController as! UINavigationController
            let preVC = nav.topViewController as! PostDetailViewController
            preVC.viewModel.boardElement
                .accept(element)
        }
    }
    
    
    //MARK: LifeCycle
    deinit {
        print("===EditView Deinit===")
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        self.title = "새싹농장 글쓰기"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.textView.becomeFirstResponder()
    }
}
