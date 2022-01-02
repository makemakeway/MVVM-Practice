//
//  APIService.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/27.
//

import Foundation

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
    
    static func fetchLotto(number: Int, completion: @escaping (Lotto?, APIError?) -> Void ) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Lotto.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
            
            
        }
        .resume()
    }
    
    static func fetchActor(_ text: String, _ page: Int, completion: @escaping (Actor?, APIError?) -> Void ) {
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        
        let path = "/3/search/person"
        
        let key = "ccd38448b467cea2c7dd6826eba79e39"
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let language = "ko-KR"
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "language", value: language)
        ]
        
        URLSession.shared.dataTask(with: components.url!) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(Actor.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
            
            
        }
        .resume()
    }
    
    static func fetchPost(token: String, completion: @escaping (Board?, APIError?) -> Void) {
        let url = EndPoint.boards.url
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        URLSession.request(endPoint: request, completion: completion)
    }
}
