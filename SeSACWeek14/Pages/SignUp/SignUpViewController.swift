//
//  SignUpViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: Properties
    
    
    
    //MARK: UI
    let mainView = SignUpView()
    
    
    //MARK: Method
    
    
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
        view.backgroundColor = .systemIndigo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
