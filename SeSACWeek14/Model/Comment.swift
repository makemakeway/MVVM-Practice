//
//  Comment.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/05.
//

import Foundation

// MARK: - CommentDetailElement
struct CommentDetail: Codable {
    let id: Int
    let comment: String
    let user: User
    let post: Post
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user, post
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Post
struct Post: Codable {
    let id: Int
    let text: String
    let user: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias CommentDetailElement = [CommentDetail]
