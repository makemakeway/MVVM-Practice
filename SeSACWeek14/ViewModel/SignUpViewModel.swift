//
//  SignUpViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import Foundation

class SignUpViewModel {
    var email: Observable<String> = Observable("")
    var username: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var confirmPassword: Observable<String> = Observable("")
    
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
}
