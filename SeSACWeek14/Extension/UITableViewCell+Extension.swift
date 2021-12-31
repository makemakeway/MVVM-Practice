//
//  UITableViewCell+Extension.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/31.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String {
        get
    }
}


extension UITableViewCell: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
