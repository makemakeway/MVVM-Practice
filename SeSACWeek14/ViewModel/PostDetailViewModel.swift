//
//  PostDetailViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/05.
//

import Foundation
import RxSwift
import RxRelay

class PostDetailViewModel {
    
    var boardElement: BehaviorRelay<BoardElement>
    var commentsObservable: BehaviorRelay<[Comment]>
    var commentText = BehaviorRelay(value: "")
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    func postComment() {
        guard let token = token else {
            return
        }
        print("Upload Comment")
    }
    
    init(element: BoardElement) {
        self.boardElement = BehaviorRelay(value: element)
        self.commentsObservable = BehaviorRelay(value: element.comments)
    }
}
