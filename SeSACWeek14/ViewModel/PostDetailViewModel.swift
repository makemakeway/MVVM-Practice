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
    var editCommentText = BehaviorRelay(value: "")
    var fetchCommentErrorObservable = PublishSubject<APIError>()
    var fetchPostObservable = PublishSubject<APIError>()
    
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    func fetchPost() {
        guard let token = token else {
            return
        }
        print("fetch Post")
        let postId = boardElement.value.id
        LoadingIndicator.shared.showIndicator()
        APIService.fetchDetailPost(token: token, postId: postId) { [weak self](element, error) in
            guard let self = self else { return }
            guard let error = error else {
                self.boardElement.accept(element!)
                LoadingIndicator.shared.hideIndicator()
                print("fetch Post Completed")
                return
            }
            self.fetchPostObservable.onNext(error)
        }
        
    }
    
    func deletePost() {
        guard let token = token else {
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
    
    func fetchComment() {
        guard let token = token else {
            return
        }
        print("fetch Comment")
        let postId = boardElement.value.id
        
        LoadingIndicator.shared.showIndicator()
        APIService.fetchComment(token: token, postId: postId) { [weak self](element, error) in
            LoadingIndicator.shared.hideIndicator()
            guard error == nil else {
                self?.fetchCommentErrorObservable.onNext(error!)
                return
            }
            guard let comments = element else {
                return
            }
            self?.commentsObservable
                .onNext(comments)
            print("fetch Comment Completed")
        }
    }
    
    func fetchComment(completion: @escaping () -> Void) {
        guard let token = token else {
            return
        }
        let postId = boardElement.value.id
        
        LoadingIndicator.shared.showIndicator()
        APIService.fetchComment(token: token, postId: postId) { [weak self](element, error) in
            LoadingIndicator.shared.hideIndicator()
            guard error == nil else {
                self?.fetchCommentErrorObservable.onNext(error!)
                return
            }
            guard let comments = element else {
                return
            }
            self?.commentsObservable
                .onNext(comments)
            completion()
        }
    }
    
    func postComment(completion: @escaping (APIError?) -> Void) {
        guard let token = token else {
            return
        }
        let postId = boardElement.value.id
        
        LoadingIndicator.shared.showIndicator()
        APIService.addComment(token: token, postId: postId, comment: commentText.value) { (value, error) in
            LoadingIndicator.shared.hideIndicator()
            guard error == nil else {
                print(error!)
                completion(error!)
                return
            }
            completion(nil)
        }
    }
    
    func deleteComment(commentId: Int, postId: Int, completion: @escaping (APIError?) -> Void) {
        guard let token = token else {
            return
        }
        LoadingIndicator.shared.showIndicator()
        APIService.deleteComment(token: token, commentId: commentId) { [weak self](error) in
            LoadingIndicator.shared.hideIndicator()
            guard error == nil else {
                print(error!)
                completion(error!)
                return
            }
            self?.fetchComment()
        }
    }
    
    func editComment(commentId: Int, postId: Int, completion: @escaping (APIError?) -> Void) {
        guard let token = token else {
            return
        }

        LoadingIndicator.shared.showIndicator()
        APIService.editComment(token: token, commentId: commentId, postId: postId, comment: editCommentText.value) { [weak self](error) in
            guard error == nil else {
                completion(error!)
                return
            }
            self?.fetchComment()
        }
    }
    
    init(element: BoardElement) {
        self.boardElement = BehaviorRelay(value: element)
        fetchPost()
        fetchComment()
    }
}
