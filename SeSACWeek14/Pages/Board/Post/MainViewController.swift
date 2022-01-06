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
                
                //MARK: date 처리하는 부분 뷰모델에서 처리해야 할 것 같은데 엏덯게해야할지모르겟다
                let date = DateManager.shared.stringToDate(string: element.updatedAt)
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
        self.title = "새싹농장"
        mainView.tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.reuseIdentifier)
        mainView.tableView.rowHeight = UITableView.automaticDimension
        bind()
        
        viewModel.fetchBoard()
        
        print(UserDefaults.standard.string(forKey: "token"))
    }
}
