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
        mainView.showSkeletonView()
        viewModel.postUserLogin { [weak self](error) in
            
            guard error == nil else {
                self?.mainView.hideSkeleton()
                return
            }
            
            let vc = MainViewController()
            self?.changeRootView(viewController: vc)
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

