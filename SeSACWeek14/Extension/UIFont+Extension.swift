//
//  UIFont+Extension.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/05.
//
import UIKit

extension UIFont {
    var contentFontRegular: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    var contentFontBold: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    var mainFontRegular: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
    var mainFontBold: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    var smallFontRegular: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
}
