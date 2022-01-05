//
//  APIService.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
    case tokenExpired
}

class APIService {
    static func login(identifier: String, password: String, completion: @escaping (UserAuth?, APIError?) -> Void ) {
        let url = EndPoint.login.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endPoint: request, completion: completion)
    }
    
    
    static func signUp(username: String, email:String, password: String, completion: @escaping (UserAuth?, APIError?) -> Void) {
        let url = EndPoint.signup.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endPoint: request, completion: completion)
        
    }
    
    static func changePassword(currentPassword: String, newPassword: String, confirmNewPassword: String, completion: @escaping (UserAuth?, APIError?) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            completion(nil, .tokenExpired)
            return
        }
        
        let url = EndPoint.changePassword.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "currentPassword=\(currentPassword)&newPassword=\(newPassword)&confirmNewPassword=\(confirmNewPassword)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, .invalidResponse)
                return
            }
            switch response.statusCode {
            case 200:
                completion(nil, nil)
            case 401:
                completion(nil, .tokenExpired)
            case 400:
                completion(nil, .invalidData)
            default:
                completion(nil, .failed)
            }
        }.resume()
    }
    
    static func fetchPost(token: String, completion: @escaping (Board?, APIError?) -> Void) {
        let url = EndPoint.boards.url
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endPoint: request, completion: completion)
    }
    
    static func addPost(token: String, text: String, completion: @escaping (APIError?) -> Void) {
        let url = EndPoint.boards.url
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endPoint: request, completion: completion)
    }
    
    static func fetchComment(token: String, postId: Int, completion: @escaping (CommentDetailElement?, APIError?) -> Void) {
        let urlString = "http://test.monocoding.com:1231/comments"
        var component = URLComponents(string: urlString)
        let query = URLQueryItem(name: "post", value: "\(postId)")
        component?.queryItems = [query]
        
        let url = component?.url
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endPoint: request, completion: completion)
    }
}
