//
//  Requests.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 15.07.2022.
//

import Foundation
import WebKit

class Requests {
    private let decoder = JSONDecoder ()
    
    //создал свойства класса (хранимые свойства) - тем самым их инициализировав
    var partUrlFriendsAddList = URLComponents(string: "https://api.vk.com/method/friends.addList")
    var partUrlFriendsGet = URLComponents(string: "https://api.vk.com/method/friends.get")
    var partUrlUsersGet = URLComponents(string: "https://api.vk.com/method/users.get")
    var partUrlGroupsGet = URLComponents(string: "https://api.vk.com/method/groups.get")
    var partUrlGroupsSearch = URLComponents(string: "https://api.vk.com/method/groups.search")
    
    //создал методы запросов, которые используют свойства класса
    
    func requestFriendsGet() { // Возвращает список nickname моих друзей и их Str photo_50
        var urlComponents = partUrlFriendsGet
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
            URLQueryItem(name: "fields", value: "nickname, photo_50"),
            URLQueryItem(name: "count", value: "15"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlFriendsGet = urlComponents?.url else { return }//создаем url из компонентов
        
        URLSession.shared.dataTask(with: urlFriendsGet) { data, response, error in
            guard let jsonData = data else { return }
            do {
                let FriendsGetUp = try self.decoder.decode(FriendsGetUp.self, from: jsonData)
                //.map { $0.title }// посредством этого выведет только title
                let FriendsGet = FriendsGetUp.response?.items ?? []
                print("\n\n------------------------------------\n\n")
                print(FriendsGet)
            } catch {
                print(error)
            }
            
        }.resume() // !!! обязательно запускаем задачу - загружает данные с сервера
    }
    
    
    //    func requestUsersGet() { //Возвращает расширенную информацию о пользователях
    //        var urlComponents = partUrlUsersGet
    //        urlComponents?.queryItems = [
    //            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
    //            URLQueryItem(name: "user_ids", value: "1972901"),
    //            URLQueryItem(name: "fields", value: "photo_200"),
    //            URLQueryItem(name: "v", value: "5.131")
    //        ]
    //        guard let url = urlComponents?.url else { return }//создаем url из компонентов
    //
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            print("Error_users.get --> \(String(describing: error))")
    //            print("Response --> \(String(describing: response))")
    //
    //            guard let data = data else { return }
    //            print("\n\n------------------------------------\n\n")
    //            print("Body --> \(String(describing: String(data: data, encoding: .utf8)))")//переводим данные в строку
    //
    //        }.resume() // !!! обязательно запускаем задачу
    //    }
    //
    //
    //    func requestGroupsGet() { //Возвращает список сообществ указанного пользователя.
    //        var urlComponents = partUrlGroupsGet
    //        urlComponents?.queryItems = [
    //            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
    //            URLQueryItem(name: "user_id", value: "1972901"),
    //            URLQueryItem(name: "count", value: "2"),
    //            URLQueryItem(name: "v", value: "5.131")
    //        ]
    //        guard let url = urlComponents?.url else { return }//создаем url из компонентов
    //
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            print("Error_groups.get --> \(String(describing: error))")
    //            print("Response --> \(String(describing: response))")
    //
    //            guard let data = data else { return }
    //            print("\n\n------------------------------------\n\n")
    //            print("Body --> \(String(describing: String(data: data, encoding: .utf8)))")//переводим данные в строку
    //
    //        }.resume() // !!! обязательно запускаем задачу
    //    }
    //
    //    func requestGroupsSearch() { //Осуществляет поиск сообществ по заданной подстроке.
    //        var urlComponents = partUrlGroupsSearch
    //        urlComponents?.queryItems = [
    //            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
    //            URLQueryItem(name: "q", value: "iOS"),
    //            URLQueryItem(name: "type", value: "group"),
    //            URLQueryItem(name: "count", value: "2"),
    //            URLQueryItem(name: "v", value: "5.131")
    //        ]
    //        guard let url = urlComponents?.url else { return }//создаем url из компонентов
    //
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            print("Errorgroups.search --> \(String(describing: error))")
    //            print("Response --> \(String(describing: response))")
    //
    //            guard let data = data else { return }
    //            print("\n\n-------------------------------------\n\n")
    //            print("Body --> \(String(describing: String(data: data, encoding: .utf8)))")//переводим данные в строку
    //
    //        }.resume() // !!! обязательно запускаем задачу
    //    }
}
