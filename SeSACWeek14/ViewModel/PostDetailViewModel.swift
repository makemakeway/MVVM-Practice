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
    var commentsObservable: PublishSubject<CommentDetailElement> = PublishSubject()
    var commentText = BehaviorRelay(value: "")
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    func fetchComment(postId: Int) {
        guard let token = token else {
            return
        }
        APIService.fetchComment(token: token, postId: postId) { [weak self](element, error) in
            guard error == nil else {
                print(error!)
                return
            }
            guard let comments = element else {
                return
            }
            self?.commentsObservable
                .onNext(comments)
        }
    }
    
    func postComment() {
        
    }
    
    init(element: BoardElement) {
        self.boardElement = BehaviorRelay(value: element)
        fetchComment(postId: element.id)
    }
}
