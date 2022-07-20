//
//  GroupsGet.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 20.07.2022.
//

import Foundation

struct GroupData: Decodable {
    let response: Objects?
}
struct Objects: Decodable {
    let count: Int?
    let items: [groupIds]?
}

struct groupIds: Decodable {
}
