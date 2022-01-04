//
//  EditViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/04.
//

import Foundation
import RxSwift

class EditViewModel {
    var textContent = BehaviorSubject(value: "")
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    func postTextContent() {
        guard let token = token else {
            textContent.onError(APIError.tokenExpired)
            return
        }
        let text = try! textContent.value()
        LoadingIndicator.shared.showIndicator()
        APIService.addPost(token: token, text: text) { [weak self](error) in
            print("===포스트 추가===")
            guard let error = error else {
                self?.textContent.onCompleted()
                LoadingIndicator.shared.hideIndicator()
                return
            }
            
            switch error {
            case .invalidResponse:
                self?.textContent.onError(APIError.invalidResponse)
            case .tokenExpired:
                self?.textContent.onError(APIError.tokenExpired)
            case .noData:
                self?.textContent.onError(APIError.noData)
            case .failed:
                self?.textContent.onError(APIError.failed)
            case .invalidData:
                self?.textContent.onError(APIError.invalidData)
            }
            LoadingIndicator.shared.hideIndicator()
        }
    }
    
}
