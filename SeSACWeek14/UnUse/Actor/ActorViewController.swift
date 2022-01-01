//
//  ActorViewController.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/28.
//

import UIKit

class ActorViewController: UIViewController {
    
    //MARK: Properties
    private var viewModel = ActorViewModel()
    
    //MARK: UI
    fileprivate var tableView = UITableView()
    fileprivate var searchBar = UISearchBar()
    
    
    //MARK: Method
    
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        searchBar.delegate = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        viewModel.actor.bind { act in
            self.tableView.reloadData()
        }
    }
}

extension ActorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = "\(data.name) | \(data.knownForDepartment)"
        return cell
    }
}

extension ActorViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.fetchActor(searchBar.text ?? "", 1)
    }
}
