//
//  ChangePasswordViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/02.
//

import UIKit
import RxCocoa
import RxSwift

class ChangePasswordViewController: UIViewController {
    //MARK: Properties
    
    let viewModel = ChangePasswordViewModel()
    
    let disposeBag = DisposeBag()
    
    //MARK: UI
    
    let mainView = ChangePasswordView()
    
    //MARK: Method
    
    @objc func changeButtonClicked(_ sender: UIButton) {
        print("Change")
        viewModel.changePassword { [weak self](error) in
            guard let self = self else { return }
            
            guard error != nil else {
                self.makeAlert(title: "성공", message: "비밀번호 변경 완료", buttonTitle: "확인", completion: nil)
                return
            }
            
            switch error {
            case .tokenExpired:
                self.makeAlert(title: "오류", message: "토큰이 만료되었습니다.\n로그인 후 다시 시도해주세요.", buttonTitle: "확인") { _ in
                    let vc = SignInViewController()
                    self.changeRootView(viewController: vc)
                }
            case .failed:
                self.makeAlert(title: "오류", message: "비밀번호 변경에 실패했습니다.", buttonTitle: "확인", completion: nil)
            case .invalidData:
                self.makeAlert(title: "오류", message: "비밀번호를 다시한번 확인해주세요.", buttonTitle: "확인", completion: nil)
            default:
                self.makeAlert(title: "오류", message: "비밀번호 변경 실패.", buttonTitle: "확인", completion: nil)
            }
        }
    }
    
    func bind() {
        mainView.newPasswordTextField.rx.text.orEmpty
            .bind(to: viewModel.newPassword)
            .disposed(by: disposeBag)
        
        mainView.currentPasswordTextField.rx.text.orEmpty
            .bind(to: viewModel.oldPassword)
            .disposed(by: disposeBag)
        
        mainView.confirmNewPasswordTextField.rx.text.orEmpty
            .bind(to: viewModel.newPasswordConfirm)
            .disposed(by: disposeBag)
        
        mainView.confirmButton.addTarget(self, action: #selector(changeButtonClicked(_:)), for: .touchUpInside)
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
