//
//  ChangePasswordViewModel.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/02.
//

import Foundation
import RxRelay

class ChangePasswordViewModel {
    var oldPassword = BehaviorRelay(value: "")
    var newPassword = BehaviorRelay(value: "")
    var newPasswordConfirm = BehaviorRelay(value: "")
    
    func changePassword(completion: @escaping ((APIError?) -> Void)) {
        APIService.changePassword(currentPassword: oldPassword.value,
                                  newPassword: newPassword.value,
                                  confirmNewPassword: newPasswordConfirm.value) { _, error in
            completion(error)
        }
    }
}
