//
//  EditViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/04.
//

import Foundation
import RxSwift
import RxRelay

class EditViewModel {
    var textContent = BehaviorRelay(value: "")
    var tap = PublishSubject<Void>()
    var element = PublishSubject<BoardElement>()
    var postId: Int? = nil
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    func editPostContent(completion: @escaping (APIError?) -> Void) {
        guard let token = token else {
            tap.onError(APIError.tokenExpired)
            return
        }
        guard let postId = postId else {
            print("post ID nil")
            return
        }

        LoadingIndicator.shared.showIndicator()
        let text = textContent.value
        APIService.editPost(token: token, text: text, id: postId) { [weak self](element,error)  in
            guard let error = error else {
                print("===포스트 수정완료===")
                self?.element.onNext(element!)
                self?.tap.onCompleted()
                LoadingIndicator.shared.hideIndicator()
                return
            }
            completion(error)
            LoadingIndicator.shared.hideIndicator()
        }
    }
    
    func postTextContent(completion: @escaping (APIError?) -> Void) {
        guard let token = token else {
            tap.onError(APIError.tokenExpired)
            return
        }
        let text = textContent.value
        LoadingIndicator.shared.showIndicator()
        APIService.addPost(token: token, text: text) { [weak self](error) in
            guard let error = error else {
                print("===포스트 추가완료===")
                self?.tap.onCompleted()
                LoadingIndicator.shared.hideIndicator()
                return
            }
            completion(error)
            LoadingIndicator.shared.hideIndicator()
        }
    }
    

    
}
