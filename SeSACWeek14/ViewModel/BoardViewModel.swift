//
//  BoardViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/29.
//

import Foundation

class BoardViewModel {
    var boards: Observable<Board> = Observable(Board())
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    func fetchBoard(completion: @escaping () -> Void) {
        guard let token = token else {
            return
        }

        LoadingIndicator.shared.showIndicator()
        
        APIService.fetchPost(token: token) { [weak self](board, error) in
            LoadingIndicator.shared.hideIndicator()
            guard let self = self else { return }
            guard error == nil else {
                if error == .tokenExpired {
                    completion()
                }
                return
            }
            guard let board = board else { return }
            self.boards.value = board
        }
    }
}

extension BoardViewModel {
    var numberOfRows: Int {
        return boards.value.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> BoardElement {
        return boards.value[indexPath.row]
    }
}
