//
//  JsonDecoder.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 19.07.2022.
//

import Foundation


//class JsonDecoder {
//
//    private let jsonDecoder = JSONDecoder()//59м вызываем декодер 1 раз, чтобы не расходовать память как если бы он каждый раз создавался бы в функции
//
//    func decode(for data: Data) throws -> FriendsGetUp { //data - абстрактная обертка данныхСети
//        return try jsonDecoder.decode(FriendsGetUp.self, from: data)//[], тк у нас корневой элемет-массив; в однострочных методах return вызывать необязательно - можно без return
//    }
//}
