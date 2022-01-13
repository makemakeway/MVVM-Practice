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

//MARK: 메모리 누수 확인
class EditPostViewController: UIViewController {
    //MARK: Properties
    
    var viewModel = EditViewModel()
    var disposeBag = DisposeBag()
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
                //MARK: Post Detail로 빠져나가는 경우 댓글이 사라지는 버그
            }
            .disposed(by: disposeBag)
        
        mainView.confirmButton.rx.tap
            .bind { [weak self](_) in
                guard let self = self else { return }
                print("tap")
                switch self.editCase {
                case .add:
                    self.viewModel.postTextContent { [weak self](error) in
                        guard let error = error else {
                            return
                        }
                        self?.APIErrorHandler(error: error, message: "포스트 작성에 실패했습니다.")
                    }
                case .edit:
                    self.viewModel.editPostContent { [weak self](error) in
                        guard let error = error else {
                            return
                        }
                        self?.APIErrorHandler(error: error, message: "포스트 수정에 실패했습니다.")
                    }
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
                self?.dataPushAtPresentingVC()
            }
            .disposed(by: disposeBag)
    }
    
    func dataPushAtPresentingVC() {
        switch editCase {
        case .add:
            let nav = presentingViewController as! UINavigationController
            let preVC = nav.topViewController as! MainViewController
            dismiss(animated: true) {
                preVC.viewModel.fetchBoard()
                preVC.mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        case .edit:
            let nav = presentingViewController as! UINavigationController
            let preVC = nav.topViewController as! PostDetailViewController
            dismiss(animated: true) {
                preVC.viewModel.fetchPost()
                preVC.viewModel.fetchComment()
            }
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag = DisposeBag()
    }
}

extension EditPostViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
