//
//  UIViewController+Extension.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/31.
//

import UIKit

extension UIViewController {
    func makeAlert(title: String, message: String, buttonTitle: String, completion: ((UIAlertAction) -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: buttonTitle, style: .default, handler: completion)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func deleteAlert(title: String, message: String, buttonTitle: String, completion: ((UIAlertAction) -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let delete = UIAlertAction(title: buttonTitle, style: .default, handler: completion)
            let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
            alert.addAction(delete)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func changeRootView(viewController: UIViewController) {
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: viewController)
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }
    
    func APIErrorHandler(error: APIError, message: String) {
        switch error {
        case .tokenExpired:
            makeAlert(title: "오류", message: "토큰이 만료되었습니다.\n다시 로그인 해주세요.", buttonTitle: "확인") { [weak self](_) in
                self?.changeRootView(viewController: SignInViewController())
            }
        default:
            makeAlert(title: "오류", message: message, buttonTitle: "확인", completion: nil)
        }
    }
}
