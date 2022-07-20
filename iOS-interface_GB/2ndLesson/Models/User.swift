//
//  User.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 19.07.2022.
//

import Foundation

struct User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let deactivated: String
    let isClosed: Bool
    let canAccessClosed: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case deactivated
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
    }
}
