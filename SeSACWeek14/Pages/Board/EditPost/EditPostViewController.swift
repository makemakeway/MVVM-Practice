//
//  EditPostViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/03.
//

import UIKit

class EditPostViewController: UIViewController {
    //MARK: Properties
    
    
    
    //MARK: UI
    let mainView = EditPostView()
    
    
    //MARK: Method
    
    
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
