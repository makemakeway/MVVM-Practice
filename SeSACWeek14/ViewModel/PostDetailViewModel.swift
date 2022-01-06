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
    var deleteObservable = PublishSubject<APIError?>()
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    func deletePost() {
        guard let token = token else {
            print("토큰 만료처리")
            return
        }
        let postId = boardElement.value.id
        LoadingIndicator.shared.showIndicator()
        APIService.deletePost(token: token, id: postId) { [weak self](error) in
            guard let error = error else {
                print("===포스트 삭제완료")
                self?.deleteObservable.onNext(nil)
                LoadingIndicator.shared.hideIndicator()
                return
            }
            print("여기에 에러처리")
            self?.deleteObservable.onNext(error)
            LoadingIndicator.shared.hideIndicator()
        }
    }
    
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
