//
//  MainViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Properties
    
    
    
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
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "zzzzz"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
