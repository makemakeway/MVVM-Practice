//
//  SignUpViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: Properties
    
    let viewModel = SignUpViewModel()
    let logInViewModel = SignInViewModel()
    
    //MARK: UI
    let mainView = SignUpView()
    
    
    //MARK: Method
    @objc func signUpButtonClicked() {
        print("Sign UP")
        if viewModel.password.value != viewModel.confirmPassword.value {
            makeAlert(title: "오류", message: "비밀번호를 확인해주세요.", buttonTitle: "확인")
            return
        }
        
        mainView.showSkeletonView()
        viewModel.registerUser { [weak self] (userData, error) in
            guard let self = self else { return }
            guard error == nil else {
                // 여기 알럿 띄워주고
                self.makeAlert(title: "오류", message: "회원가입에 실패했습니다.", buttonTitle: "확인")
                self.mainView.hideSkeletonView()
                return
            }
            DispatchQueue.main.async {
                self.logInViewModel.email.value = self.viewModel.username.value
                self.logInViewModel.password.value = self.viewModel.password.value
                self.logInViewModel.postUserLogin {
                    
                    DispatchQueue.main.async {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                            return
                        }
                        windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                        windowScene.windows.first?.makeKeyAndVisible()
                    }
                }
            }
            
        }
    }
    
    @objc func emailTextFieldDidChanged(_ textField: UITextField) {
        viewModel.email.value = mainView.emailTextField.text ?? ""
    }
    
    @objc func userNameTextFieldDidChanged(_ textField: UITextField) {
        viewModel.username.value = mainView.usernameTextField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChanged(_ textField: UITextField) {
        viewModel.password.value = mainView.passwordTextField.text ?? ""
    }
    
    @objc func confirmPasswordTextFieldDidChanged(_ textField: UITextField) {
        viewModel.confirmPassword.value = mainView.passwordTextField.text ?? ""
    }
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
        view.backgroundColor = .systemIndigo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChanged(_:)), for: .editingChanged)
        mainView.usernameTextField.addTarget(self, action: #selector(userNameTextFieldDidChanged(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChanged(_:)), for: .editingChanged)
    }
}
