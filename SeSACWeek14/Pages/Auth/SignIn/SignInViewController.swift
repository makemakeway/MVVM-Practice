//
//  ViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    //MARK: Properties
    var viewModel = SignInViewModel()
    let disposeBag = DisposeBag()
    
    //MARK: UI
    let mainView = SignInView()
    
    
    //MARK: Method
    @objc func signInButtonClicked() {
        print("Clicked")
        if mainView.emailTextField.text!.isEmpty || mainView.passwordTextField.text!.isEmpty {
            makeAlert(title: "오류", message: "아이디와 비밀번호를 입력해주세요.", buttonTitle: "확인", completion: nil)
            return
        }
        
        mainView.showSkeletonView()
        viewModel.postUserLogin { [weak self](error) in
            
            guard let error = error else {
                self?.mainView.hideSkeleton()
                let vc = MainViewController()
                self?.changeRootView(viewController: vc)
                return
            }

            self?.APIErrorHandler(error: error, message: "아이디와 비밀번호를 확인해주세요.")
            self?.mainView.hideSkeleton()
        }
    }
    
    @objc func signUpButtonClicked() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func bind() {
        mainView.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
    }
    
    //MARK: LifeCycle
    override func loadView() {
        print(#function)
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        mainView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
    }
}

