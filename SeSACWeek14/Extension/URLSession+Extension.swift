//
//  URLSession+Extension.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2021/12/31.
//

import Foundation

extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endPoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endPoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endPoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        session.dataTask(endPoint) { data, response, error in
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
                switch response.statusCode {
                case 401:
                    completion(nil, .tokenExpired)
                    return
                case 200:
                    do {
                        let decoder = JSONDecoder()
                        let userData = try decoder.decode(T.self, from: data)
                        completion(userData, nil)
                        return
                    } catch {
                        completion(nil, .invalidData)
                    }
                default:
                    completion(nil, .failed)
                    return
                }
            }
        }
    }
    
    static func request(_ session: URLSession = .shared, endPoint: URLRequest, completion: @escaping (APIError?) -> Void) {
        session.dataTask(endPoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failed)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(.invalidResponse)
                    return
                }
                switch response.statusCode {
                case 401:
                    completion(.tokenExpired)
                    return
                case 200:
                    completion(nil)
                default:
                    completion(.failed)
                    return
                }
            }
        }
    }
}
