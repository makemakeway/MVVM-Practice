//
//  BoardViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/29.
//

import UIKit
import RxSwift

class BoardViewModel {
    var boards: PublishSubject<Board> = PublishSubject()
    var errorObservable: PublishSubject<APIError> = PublishSubject()
    
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
            self?.boards.onNext(board)
            
            LoadingIndicator.shared.hideIndicator()
        }
    }
}
