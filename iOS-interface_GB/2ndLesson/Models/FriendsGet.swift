//
//  ListOfFriends.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 19.07.2022.
//

import Foundation
//3.3
struct FriendsGetUp: Decodable {
    let response: Response?
}

struct Response: Decodable {
    let count: Int
    let items: [FriendsGet]
}

struct FriendsGet: Decodable {
    let nickname: String?
    let photo50: String?
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case photo50 = "photo_50"
    }
}
