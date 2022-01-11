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
    
    var start = 1
    var limit = 0
    var counts = 0
    
    //MARK: UI
    let mainView = BoardView()
    
    //MARK: Method
    
    func addPostButtonClicked() {
        let vc = EditPostViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func bind() {
        mainView.tableView.rx.modelSelected(BoardElement.self)
            .subscribe { [weak self](value) in
                let vc = PostDetailViewController(element: value)
                self?.navigationController?.pushViewController(vc, animated: true)
            } onError: { error in
                print(error)
            } onCompleted: {
                
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)

        
        viewModel.boardViewModel
            .bind(to: mainView.tableView.rx.items) { (tableView, row, element) in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.reuseIdentifier) as? BoardTableViewCell else { return UITableViewCell() }
                
                cell.usernameLabel.text = element.user.username
                cell.contentLabel.text = element.text
                
                let date = DateManager.shared.stringToDate(string: element.createdAt)
                let dateString = DateManager.shared.dateToString(date: date)
                
                cell.dateLabel.text = dateString
                cell.selectionStyle = .none
                
                if element.comments.count == 0 {
                    cell.commentLabel.text = "댓글쓰기"
                } else {
                    cell.commentLabel.text = "댓글 \(element.comments.count)"
                }
                
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.errorObservable
            .subscribe { [weak self](error) in
                guard let error = error.element else {
                    return
                }
                self?.APIErrorHandler(error: error, message: "댓글 불러오는 것을 실패했습니다.")
            }
            .disposed(by: disposeBag)
        
        mainView.addPostButton.rx.tap
            .bind { [weak self](_) in
                self?.addPostButtonClicked()
            }
    }
    
    //MARK: LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "새싹농장"
        mainView.tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.reuseIdentifier)
        mainView.tableView.rowHeight = UITableView.automaticDimension
        bind()
        
        viewModel.fetchBoard(start: 1, limit: 10)
        APIService.fetchPostCount(token: UserDefaults.standard.string(forKey: "token")!) { [weak self](count, error) in
            guard let count = count else {
                return
            }
            self?.counts = count
        }
        print(UserDefaults.standard.string(forKey: "token")!)
    }
}
