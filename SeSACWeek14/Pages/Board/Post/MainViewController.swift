//
//  MainViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Properties
    let viewModel = BoardViewModel()
    
    
    //MARK: UI
    let mainView = BoardView()
    
    //MARK: Method
    
    @objc func addPostButtonClicked(_ sender: UIButton) {
        let vc = EditPostViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.reuseIdentifier)
        
        mainView.addPostButton.addTarget(self, action: #selector(addPostButtonClicked(_:)), for: .touchUpInside)
        
        viewModel.fetchBoard { [weak self] in
            // 오류가 있을 경우에만 completion으로 넘어옴
            self?.makeAlert(title: "오류", message: "토큰이 만료되었습니다. 다시 로그인을 해주세요.", buttonTitle: "확인") { (_) in
                let vc = SignInViewController()
                self?.changeRootView(viewController: vc)
            }
        }
        viewModel.boards.bind({ [weak self](board) in
            self?.mainView.tableView.reloadData()
        })
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRowAt(tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
