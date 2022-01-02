//
//  ChangePasswordViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/02.
//

import Foundation

class ChangePasswordViewModel {
    var oldPassword: Observable<String> = Observable("")
    var newPassword: Observable<String> = Observable("")
    var newPasswordConfirm: Observable<String> = Observable("")
    
    func changePassword(completion: @escaping ((APIError?) -> Void)) {
        APIService.changePassword(currentPassword: oldPassword.value,
                                  newPassword: newPassword.value,
                                  confirmNewPassword: newPasswordConfirm.value) { _, error in
            completion(error)
        }
    }
}
