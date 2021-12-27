//
//  SignInViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import Foundation

class SignInViewModel {
    var username: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    
    func postUserLogin(completion: @escaping () -> Void) {
        APIService.login(identifier: username.value,
                         password: password.value) { userData, error in
            guard let userData = userData else {
                print("no data")
                return
            }
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion()
        }
    }
}
