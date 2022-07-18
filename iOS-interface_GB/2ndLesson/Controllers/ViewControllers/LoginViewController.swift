//  LoginViewController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 27.05.2022.

import UIKit
import WebKit
//3.2 прохождение авторизации
class LoginViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self// подписываемся на navigationDelegate у webView, тк если успешно пройдет авторизация, ВК отредиректит нас по адресу в строке ниже (https://oauth.vk.com/.blank.html) и по этому адресу мы сможем забрать токен
        
        var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")// адрес авторизации, чтобы не заполнять все эти поля руками, можно подставить это как строку и заполнить ниже то, чего не хватает
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "2906698"),
            URLQueryItem(name: "display", value: "mobile"),//под какое разрешение подгонять
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),//адрес, куда нужно отредиректить - важно, чтобы понять прошли ли мы авторизацию или не прошли и по этому адресу мы сможем забрать токен
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),//хотим, чтобы в ответе на запрос нам дали токен
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = urlComponents?.url else { return }//создаем url из компонентов
        print(url)
        let request = URLRequest(url: url) //создаем запрос
        
        webView.load(request) //и обращаемся к нашей VK'еевой Вью с просьбой исполнить наш запрос (до этого надо подписаться на делегат)
    }
}

//3.2.логика. Имплементируем делегат WKNavigationDelegate контроллеру и реализуем метод, который перехватывает ответы сервера при переходе - func webView
extension LoginViewController: WKNavigationDelegate {
    func webView(// тк мы подписались на WKWebView, то используем метод, кот. работает с навигацией
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        decisionHandler(.allow)//хендлер долж ен вызываться 1 раз (метод, с помощью кот.делаемПереход между страницами)
        guard let url = navigationResponse.response.url,// проверяет URL, на который было совершено перенаправление,
              url.path == "/blank.html",// если это нужный нам URL (/blank.html), и в нем есть токен, приступим к его обработке
              let fragment = url.fragment //45м и после чего собираем фрагменты строки
        else {return}
        
        let params = fragment //46 м (пример) нам приходит большая строка
        // пример: access_token=9012304asds&h=test&[y=90]
            .components(separatedBy: "&") //разбиваем параметры &ом: ["access_token=9012304asds", "h=test", "y=90"]
            .map {$0.components(separatedBy: "=") } //после преобразуем полученные строки, разделяя знаком = [["access_token", "9012304asds"], ["h", "test"], ["y", "90"]]
        //теперь нам надо превратить в читаемый вид: принимает 1ым аргументом то, что мы даем ей как пустое значение и на каждой итерации, когда идем по массиву, это значение дается нам частично заполненное
        //как происходит: 0. в гуарде и к 1ой итерации у нас в словарь уже записаны ключ и значение, в 2ой итерации мы встречаем 1ый элемент h - он передается в значение param, записываем ключ(h) и значение (test) в наш словарь (2ая итерац), на 3ей итерации (у нас уже есть ключ и значение) мы попадаем во 3ий массив ["y", "90"] - также берем ключ, значение и записываем в словарь
            .reduce ([String: String](), { partialResult, param in
                var dict = partialResult// берем наш старый словарь и
                //чтобы увелич производительность мы можем избежать первый цикл, написав:
                guard param[0] == "access_token" else { return dict }
                let key = param[0] //забираем ключ из массива - первый элемент массива
                let value = param[1] //а значением будет 2ой элемент массива
                dict[key] = value // после взятия записываем ключ и значение в наш словарь
                return dict
            })
        
        guard let token = params["access_token"] else { return }
        print(token) //1ч после того как получили токен надо сделать перенаправление на какой-то экран
/*
//чтобы совершить переход - вписать Storyboard ID вверхусправа в настройках у таббарконтроллера,ниже указан переход на контроллер созданный в сториборде
        let storyboard = UIStoryboard(name: "Main", bundle: nil) //создать UIStoryboard
        guard let secondVC = storyboard.instantiateViewController(withIdentifier:"TabBarController") as? UITabBarController else { return } // получить контроллер по идентификатору
        navigationController?.pushViewController(secondVC, animated: true)//показать в UINavigationController
*/
//так мы делаем переход на контроллер, который создали кодом:
        navigationController?.pushViewController(SecondViewShowingTheResultOfWebRequests(), animated: true)//показать в UINavigationController
    }
}

