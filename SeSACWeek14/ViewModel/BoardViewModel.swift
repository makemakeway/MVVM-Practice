//
//  BoardViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/29.
//

import UIKit
import RxSwift
import RxRelay

class BoardViewModel {
    var boardViewModel: PublishRelay<Board> = PublishRelay()
    var errorObservable: PublishSubject<APIError> = PublishSubject()
    var postCount = PublishSubject<Int>()
    
    let refreshing = BehaviorRelay(value: false)
    let refreshTrigger = PublishSubject<Void>()
    
    var board: Board = []
    
    var disposeBag = DisposeBag()
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    //MARK: 페이지네이션용
    func fetchBoard(start: Int, limit: Int) {
        guard let token = token else {
            return
        }
        LoadingIndicator.shared.showIndicator()
        
        APIService.fetchPost(token: token, start: start, limit: limit) { [weak self](board, error) in
            guard let self = self else { return }
            guard error == nil else {
                self.errorObservable.onNext(error!)
                print(error!)
                return
            }
            guard let board = board else { return }
            self.board += board
            
            self.boardViewModel.accept(self.board)
            LoadingIndicator.shared.hideIndicator()
        }
    }
    
    func fetchBoard() {
        guard let token = token else {
            return
        }
        LoadingIndicator.shared.showIndicator()
        
        APIService.fetchPost(token: token, start: 0, limit: 20) { [weak self](board, error) in
            guard let self = self else { return }
            guard error == nil else {
                self.errorObservable.onNext(error!)
                print(error!)
                return
            }
            guard let board = board else { return }
            self.board = board
            
            self.boardViewModel.accept(self.board)
            LoadingIndicator.shared.hideIndicator()
        }
    }
    
    func fetchPostCount(errorHandler: @escaping (APIError?) -> Void) {
        guard let token = token else {
            return
        }
        APIService.fetchPostCount(token: token) { [weak self](count, error) in
            guard error == nil else {
                errorHandler(error!)
                return
            }
            guard let count = count else {
                return
            }
            self?.postCount.onNext(count)
        }
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
}
