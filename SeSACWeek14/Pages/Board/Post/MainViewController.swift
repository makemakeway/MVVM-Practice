//
//  MainViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    //MARK: Properties
    let viewModel = BoardViewModel()
    
    let disposeBag = DisposeBag()
    
    //MARK: UI
    let mainView = BoardView()
    
    //MARK: Method
    
    @objc func addPostButtonClicked(_ sender: UIButton) {
        let vc = EditPostViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func bind() {
        viewModel.boards
            .bind(to: mainView.tableView.rx.items) { (tableView, row, element) in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.reuseIdentifier) as? BoardTableViewCell else { return UITableViewCell() }
                
                cell.usernameLabel.text = element.user.username
                cell.contentLabel.text = element.text
                
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.errorObservable
            .subscribe { [weak self](error) in
                self?.makeAlert(title: "오류", message: "토큰이 만료되었습니다. 다시 로그인 해주세요", buttonTitle: "확인", completion: { _ in
                    self?.changeRootView(viewController: SignInViewController())
                })
            }
            .disposed(by: disposeBag)
        
        mainView.addPostButton.addTarget(self, action: #selector(addPostButtonClicked(_:)), for: .touchUpInside)
    }
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.reuseIdentifier)
        
        bind()
        
        viewModel.fetchBoard()
        
        print(UserDefaults.standard.string(forKey: "token"))
    }
}
