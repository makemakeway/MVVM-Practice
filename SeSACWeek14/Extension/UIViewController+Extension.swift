//
//  UIViewController+Extension.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/31.
//

import UIKit

extension UIViewController {
    func makeAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
