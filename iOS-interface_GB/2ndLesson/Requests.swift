//
//  Requests.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 14.07.2022.
//

import Foundation
import UIKit

class WebRequests: UIViewController {
    
    override func viewDidLoad () {
        
        super.viewDidLoad()
        requestFriendsAddList()
        requestFriendsGet()
        requestUsersGet()
        requestGroupsGet()
        requestGroupsSearch()
    }
    

    func requestFriendsAddList() {
        var urlComponents = URLComponents(string: "https://api.vk.com/method/friends.addList")// чтобы обратиться к методу API ВКонтакте, чтобы не заполнять все эти поля руками, можно подставить часть как строку и добавить недостающ:
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
            URLQueryItem(name: "ListOfFriends", value: "new list"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlComponents?.url else { return }//создаем url из компонентов
     
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Error_friends.addList --> \(String(describing: error))")
            print("Response --> \(String(describing: response))")
            
            guard let data = data else { return }//переводим данные в строку
            print("\n\n------------------------------------\n\n")
            print("Body --> \(String(describing: String(data: data, encoding: .utf8)))")
        
        }.resume() // !!! обязательно запускаем задачу
    }
    
    
    func requestFriendsGet() { // Возвращает список идентификаторов моих друзей и nickname и photo_50
        var urlComponents = URLComponents(string: "https://api.vk.com/method/friends.get")
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
            URLQueryItem(name: "fields", value: "nickname, photo_50"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlComponents?.url else { return }//создаем url из компонентов
     
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Error_friends.get --> \(String(describing: error))")
            print("Response --> \(String(describing: response))")
            
            guard let data = data else { return }//переводим данные в строку
            print("\n\n------------------------------------\n\n")
            print("Body --> \(String(describing: String(data: data, encoding: .utf8)))")
            
        }.resume() // !!! обязательно запускаем задачу
    }
    
    
    func requestUsersGet() { //Возвращает расширенную информацию о пользователях
        var urlComponents = URLComponents(string: "https://api.vk.com/method/users.get")
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
            URLQueryItem(name: "user_ids", value: "1972901"),
            URLQueryItem(name: "fields", value: "photo_200"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlComponents?.url else { return }//создаем url из компонентов
     
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Error_users.get --> \(String(describing: error))")
            print("Response --> \(String(describing: response))")
            
            guard let data = data else { return }//переводим данные в строку
            print("\n\n------------------------------------\n\n")
            print("Body --> \(String(describing: String(data: data, encoding: .utf8)))")
            
        }.resume() // !!! обязательно запускаем задачу
    }
    
    
    func requestGroupsGet() { //Возвращает список сообществ указанного пользователя.
        var urlComponents = URLComponents(string: "https://api.vk.com/method/groups.get")
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
            URLQueryItem(name: "user_id", value: "1972901"),
            URLQueryItem(name: "count", value: "2"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlComponents?.url else { return }//создаем url из компонентов
     
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Error_groups.get --> \(String(describing: error))")
            print("Response --> \(String(describing: response))")
            
            guard let data = data else { return }//переводим данные в строку
            print("\n\n------------------------------------\n\n")
            print("Body --> \(String(describing: String(data: data, encoding: .utf8)))")
            
        }.resume() // !!! обязательно запускаем задачу
    }
    
    func requestGroupsSearch() { //Осуществляет поиск сообществ по заданной подстроке.
        var urlComponents = URLComponents(string: "https://api.vk.com/method/groups.search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
            URLQueryItem(name: "q", value: "iOS"),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "count", value: "2"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlComponents?.url else { return }//создаем url из компонентов
     
        URLSession.shared.dataTask(with: url) { data, response, error in
            print("Errorgroups.search --> \(String(describing: error))")
            print("Response --> \(String(describing: response))")
            
            guard let data = data else { return }//переводим данные в строку
            print("\n\n-------------------------------------\n\n")
            print("Body --> \(String(describing: String(data: data, encoding: .utf8)))")
            
        }.resume() // !!! обязательно запускаем задачу
    }
}


