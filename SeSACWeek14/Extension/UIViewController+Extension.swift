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
    
    func changeRootView(viewController: UIViewController) {
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: viewController)
            windowScene.windows.first?.makeKeyAndVisible()
        }
    }
}
