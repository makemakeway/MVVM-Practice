//
//  BoardViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/29.
//

import UIKit
import RxSwift

class BoardViewModel {
    var boards: Observable<Board>?
    
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
                    UserDefaults.standard.set(nil, forKey: "token")
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
    
    func cellForRowAt(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.reuseIdentifier, for: indexPath) as? BoardTableViewCell else {
            print("변환 실패")
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.contentLabel.text = boards.value[indexPath.row].text
        return cell
    }
}
