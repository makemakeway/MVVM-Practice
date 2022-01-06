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
}
