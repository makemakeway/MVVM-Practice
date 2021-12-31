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
        viewModel.fetchBoard()
        viewModel.boards.bind({ [weak self](board) in
            self?.mainView.tableView.reloadData()
        })
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.reuseIdentifier, for: indexPath) as? BoardTableViewCell else {
            print("변환 실패")
            return UITableViewCell()
        }
        cell.contentLabel.text = viewModel.cellForRowAt(at: indexPath).text
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
}
