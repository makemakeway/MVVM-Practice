//
//  BoardViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/29.
//

import UIKit
import RxSwift

class BoardViewModel {
    var boardViewModel: PublishSubject<Board> = PublishSubject()
    var errorObservable: PublishSubject<APIError> = PublishSubject()
    var postCount = PublishSubject<Int>()
    var board: Board?
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    func fetchBoard(start: Int, limit: Int) {
        guard let token = token else {
            return
        }
        LoadingIndicator.shared.showIndicator()
        
        APIService.fetchPost(token: token, start: start, limit: limit) { [weak self](board, error) in
            guard error == nil else {
                self?.errorObservable.onNext(error!)
                print(error!)
                return
            }
            guard let board = board else { return }
            self?.board = board
            
            self?.boardViewModel.onNext(board)
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
}

struct BoardForView {
    let id: Int
    let text: String
    let user: User
    let createdAt, updatedAt: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}
