//
//  EndPoint.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/29.
//

import Foundation

enum EndPoint {
    case signup
    case login
    case boards
    case boardDetail(id: Int)
    case changePassword
    case fetchComment
    case commentDetail(id: Int)
}


extension EndPoint {
    var url: URL {
        switch self {
        case .signup:
            return .makeEndPoint("auth/local/register")
        case .login:
            return .makeEndPoint("auth/local")
        case .boards:
            return .makeEndPoint("posts")
        case .boardDetail(let id):
            return .makeEndPoint("posts/\(id)")
        case .changePassword:
            return .makeEndPoint("custom/change-password")
        case .fetchComment:
            return .makeEndPoint("comments")
        case .commentDetail(let id):
            return .makeEndPoint("comments/\(id)")
        }
    }
}


extension URL {
    static let baseURL = "http://test.monocoding.com:1231/"
    static func makeEndPoint(_ endPoint: String) -> URL {
        return URL(string: baseURL + endPoint)!
    }
}



