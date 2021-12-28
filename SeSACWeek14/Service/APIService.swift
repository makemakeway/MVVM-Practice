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
}

class APIService {
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void ) {
        let url = URL(string: "http://test.monocoding.com/auth/local")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
                let userData = try decoder.decode(User.self, from: data)
                completion(userData, nil)
            } catch {
                completion(nil, .invalidData)
            }
        }
        .resume()
    }
    
    
    static func SignUp(username: String, email:String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        let url = URL(string: "http://test.monocoding.com/auth/local/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
                print("Status Code error", response.statusCode)
                completion(nil, .failed)
                return
            }
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(User.self, from: data)
                completion(userData, nil)
            } catch {
                completion(nil, .invalidData)
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
}
