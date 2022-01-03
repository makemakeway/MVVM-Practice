//
//  SignUpViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import Foundation
import RxSwift
import RxRelay

class SignUpViewModel {
    var email = BehaviorRelay(value: "")
    var username = BehaviorRelay(value: "")
    var password = BehaviorRelay(value: "")
    var confirmPassword = BehaviorRelay(value: "")
    
    func registerUser(completion: @escaping (UserAuth?, APIError?) -> Void) {
        APIService.signUp(username: username.value,
                          email: email.value,
                          password: password.value) { userData, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(userData, nil)
        }
    }
    
    func postUserLogin(completion: @escaping (APIError?) -> Void) {
        APIService.login(identifier: email.value,
                         password: password.value) { userData, error in
            guard let userData = userData else {
                print("no data")
                completion(error)
                return
            }
            print(userData.jwt)
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion(nil)
        }
    }
}
