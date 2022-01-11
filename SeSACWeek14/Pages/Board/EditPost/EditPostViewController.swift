//
//  EditPostViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift

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
                    self?.viewModel.postTextContent { [weak self](error) in
                        guard let error = error else {
                            return
                        }
                        self?.APIErrorHandler(error: error, message: "포스트 작성에 실패했습니다.")
                    }
                case .edit:
                    self?.viewModel.editPostContent { [weak self](error) in
                        guard let error = error else {
                            return
                        }
                        self?.APIErrorHandler(error: error, message: "포스트 수정에 실패했습니다.")
                    }
                case .none:
                    print("에러")
                }
            }
            .disposed(by: disposeBag)

        viewModel.tap
            .subscribe { _ in
                
            } onError: { [weak self](error) in
                if let error = error as? APIError {
                    self?.APIErrorHandler(error: error, message: "포스트 작성에 실패했습니다.")
                }
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
        
        mainView.textView.rx.contentOffset
            .map { $0.y }
            .bind { [weak self](offset) in
                print(offset)
            }
            .disposed(by: disposeBag)
    }
    
    func dataPushAtPresentingVC(element: BoardElement) {
        switch editCase {
        case .add:
            let nav = self.presentingViewController as! UINavigationController
            let preVC = nav.topViewController as! MainViewController
            preVC.viewModel.fetchBoard(start: 1, limit: 10)
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
        mainView.navBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.textView.becomeFirstResponder()
        IQKeyboardManager.shared.enable = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared.enable = true
    }
}

extension EditPostViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
