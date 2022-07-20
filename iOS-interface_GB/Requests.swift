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
    private  var partUrlToGetFriendsData = URLComponents(string: "https://api.vk.com/method/friends.get")
    private var partUrlToGetUsersData = URLComponents(string: "https://api.vk.com/method/users.get")
    private var partUrlToGetUserGroupsData = URLComponents(string: "https://api.vk.com/method/groups.get")
    
    //создал методы запросов, которые используют свойства класса
    
    func getFriendsDataAndParseIt() { // Возвращает список nickname моих друзей и их Str photo_50
        var urlComponents = partUrlToGetFriendsData
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
            URLQueryItem(name: "fields", value: "nickname, photo_50"),
            URLQueryItem(name: "count", value: "15"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlFriendsGet = urlComponents?.url else { return }//создаем url из компонентов
        
        URLSession.shared.dataTask(with: urlFriendsGet) { data, _, _ in
            guard let jsonData = data else { return }
            do {
                let model = try self.decoder.decode(FriendsGetUp.self, from: jsonData)
                print(model.response?.items.map({$0.photo50}) as Any) //map({$0.nickname}) as Any) посредством этого выведет только nickname
                print("\n\n------------------------------------\n\n")
            } catch {
                print(error) //так можем отловить ошибку и устранить
            }
        }.resume() // !!! обязательно запускаем задачу загрузить данные с сервера и отпарсить
    }
    
    
    func getUsersDataAndParseIt() { //Возвращает расширенную информацию о пользователях
        var urlComponents = partUrlToGetUsersData
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
            URLQueryItem(name: "fields", value: "domain"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlUsersData = urlComponents?.url else { return }//создаем url из компонентов
        
        URLSession.shared.dataTask(with: urlUsersData) { data, _, error in
            guard let jsonData = data else { return }
            do {
                let usersData = try self.decoder.decode(UsersGet.self, from: jsonData) //указываем корневой элемент
                
                print(usersData.response.map({$0.domain}))
                print("\n------------------------------------\n")
            } catch {
                print(error) //так можем отловить ошибку и устранить
            }
        }.resume() // !!! обязательно запускаем задачу
    }
    
    
    func getUserGroupsDataAndParseIt() { //Возвращает список сообществ указанного пользователя.
        var urlComponents = partUrlToGetUserGroupsData
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
            URLQueryItem(name: "user_id", value: "1972901"),
            URLQueryItem(name: "count", value: ""),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlUserGroupsData = urlComponents?.url else { return }//создаем url из компонентов
        
        
        URLSession.shared.dataTask(with: urlUserGroupsData) { data, _, _ in
            guard let data = data else { return }
            do {
                let userGroupsData = try self.decoder.decode(GroupData.self, from: data) //указываем корневой элемент
                
                print("The amount groups of my friend is \(userGroupsData.response?.count as Any)")
                print("\n------------------------------------\n")
            } catch {
                print(error) //так можем отловить ошибку и устранить
            }
        }.resume() // !!! обязательно запускаем задачу
    }
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
