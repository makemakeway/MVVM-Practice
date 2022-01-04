//
//  EditPostViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa

class EditPostViewController: UIViewController {
    //MARK: Properties
    
    let viewModel = EditViewModel()
    let disposeBag = DisposeBag()
    
    //MARK: UI
    let mainView = EditPostView()
    
    
    //MARK: Method
    
    func navigationBarConfig() {
        let confirmButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(confirmButtonClicked(_:)))
        self.navigationItem.setRightBarButtonItems([confirmButton], animated: false)
    }
    
    @objc func confirmButtonClicked(_ sender: UIBarButtonItem) {
        print("완료")
        viewModel.postTextContent()
        viewModel.textContent
            .subscribe { _ in
                
            } onError: { error in
                print(error)
                
            } onCompleted: { [weak self] in
                print("포스트 작성 완료")
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)

    }
    
    deinit {
        print("===EditView Deinit===")
    }
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarConfig()
        mainView.textView.rx.text.orEmpty
            .bind(to: viewModel.textContent)
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.textView.becomeFirstResponder()
    }
}
