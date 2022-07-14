//
//  URLSesssionNetworker.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 13.07.2022.
//

import Foundation
//3.2 25m
class URLSessionNetworker {
    init(
        urlSesstion: URLSession = .shared // 25м URLSession - это синглтон и можно отовсюду к ней обратиться: URLSession.shared....
    ) {
        self.urlSesstion = urlSesstion
    }

    private let urlSesstion: URLSession
    
    func request(
        with url: URL
    ) { //обратимся к URLSession и создадим задачу - dataTask (уже настроенный запрос - по умолчанию запрос GET, если обращаемся к URL), дается замыкание (3опциональных поля: данные, ответ сервера и ошибка)
        let task = urlSesstion.dataTask(with: url) { data, response, error in
            print("Error --> \(String(describing: error))")
            print("\n\n------------------------------------\n\n")
            print("Response --> \(String(describing: response))")

                guard let data = data else { return }//разворачиваем наши данные (тк они опционал)
                // в замыкании данные, полученные от сервера, мы преобразуем в json (т.е. после unwrape можем выписать то, что вернул нам сервер)
                let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            
                print("\n\n------------------------------------\n\n")
                print(json as Any) //выводим в консоль
                
            print("\n\n------------------------------------\n\n")
            print("Body --> \(String(describing: String(data: data, encoding: .utf8)))") //переводим данные в строку
            }
        task.resume() // !!! обязательно запускаем задачу
    }
   
    
// URL можно создать многими способами, простой:
    func createUrl() -> URL? {
        var urlComponents = URLComponents(string: "https://api.vk.com/method/users.get")
        
        urlComponents?.queryItems = [ // параметры запроса
            URLQueryItem(name: "access_token", value: Session.sharedInstance.userToken),
            URLQueryItem(name: "v", value: "5.131")
        ]

        return urlComponents?.url // из этих компоненов получаем URL
    }


//3.2 29mдля отправки данных на сервер применяется метод POST
//    func sendPostRequest() {
//        var urlConstructor = URLComponents()// создаем конструктор для url
//        urlConstructor.scheme = "http"
//        urlConstructor.host = "jsonplaceholder.typicode.com"
//        urlConstructor.path = "/posts"
//        urlConstructor.queryItems = [
//            URLQueryItem(name: "title", value: "foo"),
//            URLQueryItem(name: "body", value: "bar"),
//            URLQueryItem(name: "userId", value: "1")
//        ]
//
//        guard let url = urlConstructor.url else { return }
//        var urlRequest = URLRequest(url: url) //создаем запрос (принимает в себя URL)
//        urlRequest.httpMethod = "POST" // и позволяет нам указать метод запроса
//
//        urlSesstion.dataTask(with: urlRequest) { data, _, _ in //обратимся к URLSession и создадим задачу - dataTask, дается замыкание (3опциональных поля: данные, ответ сервера и ошибка), если параметр не используем, то _ (например, мы знаем, что будет какая-то ошибка ее мы выведем юзеру на экран - тогда да, иначе просто _)
//            guard let data = data else { return }
//            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//
//            print(json)
//        }.resume() //можно и не создавать  константу task - так тоже пишут(кодСтайл)
//    }
}

