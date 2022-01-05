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
    var board: Board?
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    func fetchBoard() {
        guard let token = token else {
            return
        }
        LoadingIndicator.shared.showIndicator()
        
        APIService.fetchPost(token: token) { [weak self](board, error) in
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
