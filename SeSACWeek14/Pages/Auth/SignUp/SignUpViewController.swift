//
//  SignUpViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit
import RxCocoa
import RxSwift

class SignUpViewController: UIViewController {
    //MARK: Properties
    
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    //MARK: UI
    let mainView = SignUpView()
    
    
    //MARK: Method
    @objc func signUpButtonClicked() {
        
        if viewModel.password.value != viewModel.confirmPassword.value {
            makeAlert(title: "오류", message: "비밀번호를 확인해주세요.", buttonTitle: "확인", completion: nil)
            return
        }

        mainView.showSkeletonView()
        viewModel.registerUser { [weak self] (userData, error) in
            guard let self = self else { return }
            guard error == nil else {
                // 여기 알럿 띄워주고
                self.makeAlert(title: "오류", message: "회원가입에 실패했습니다.", buttonTitle: "확인", completion: nil)
                self.mainView.hideSkeletonView()
                return
            }

            // 회원가입 성공 후 로그인
            self.viewModel.postUserLogin { error in
                guard error == nil else {
                    self.mainView.hideSkeletonView()
                    return
                }
                
                let vc = MainViewController()
                self.changeRootView(viewController: vc)
            }
        }
    }
    
    func bind() {
        mainView.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        mainView.usernameTextField.rx.text.orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        mainView.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        mainView.confirmTextField.rx.text.orEmpty
            .bind(to: viewModel.confirmPassword)
            .disposed(by: disposeBag)
        
        mainView.signUpButton.rx.tap
            .observe(on: ConcurrentMainScheduler.instance)
            .bind { [weak self] in
                self?.signUpButtonClicked()
            }
            .disposed(by: disposeBag)
    }
    
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
        view.backgroundColor = .systemIndigo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}
