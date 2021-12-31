//
//  ViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit

class SignInViewController: UIViewController {

    //MARK: Properties
    var viewModel = SignInViewModel()
    
    
    //MARK: UI
    let mainView = SignInView()
    
    
    //MARK: Method
    @objc func signInButtonClicked() {
        print("Clicked")
        mainView.showSkeletonView()
        viewModel.postUserLogin {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                    return
                }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
    
    @objc func signUpButtonClicked() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func emailTextFieldDidChanged(_ textField: UITextField) {
        viewModel.email.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }
    
    
    //MARK: LifeCycle
    override func loadView() {
        print(#function)
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        
        viewModel.email.bind { text in
            self.mainView.emailTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChanged(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
    }


}

