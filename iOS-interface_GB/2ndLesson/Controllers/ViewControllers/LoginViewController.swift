//
//  LoginViewController.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 27.05.2022.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingFirstView: UIView!
    @IBOutlet weak var loadingSecondView: UIView!
    @IBOutlet weak var loadingThirdView: UIView!
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var passwordTitle: UILabel!
    @IBOutlet weak var appLabel: UIImageView!
    
    @IBOutlet weak var webView: WKWebView! {//3.2.
        didSet { webView.navigationDelegate = self } // установим webView в качестве делегата контроллера
    }
    
    let toTabBarController = "toTabBarController" //делать константу не строкой, чтобы если дальше ошибемся, то Xcode нам подскажет где ошиблись, а в строке в кавычках он не распознает опечатку
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //7урок:сделаем перемигающие точки загрузки:
        loadingFirstView.alpha = 0
        loadingSecondView.alpha = 0
        loadingThirdView.alpha = 0
        // подготовим и закруглим углы Вьбшным квардратам
        loadingFirstView.layer.cornerRadius = 5
        loadingSecondView.layer.cornerRadius = 5
        loadingThirdView.layer.cornerRadius = 5
        
        let recognizerTwo = UILongPressGestureRecognizer(target: self, action: #selector(onPush))
        self.view.addGestureRecognizer(recognizerTwo)
        
        //3.2.: отсюда и до конца метода
        webView.navigationDelegate = self// подписываемся на navigationDelegate у webView, тк если успешно пройдет авторизация, ВК отредиректит нас по адресу в строке ниже (https://oauth.vk.com/.blank.html) и по этому адресу мы сможем забрать токен
        
        var urlComponents = URLComponents(string: "https://oauth.vk.com/authorize")// адрес авторизации, чтобы не заполнять все эти поля руками, можно подставить это как строку и заполнить ниже то, чего не хватает
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "8217224"),
            URLQueryItem(name: "display", value: "mobile"),//под какое разрешение подгонять
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),//адрес, куда нужно отредиректить - важно, чтобы понять прошли мы авторизацию или не прошли и по этому адресу мы сможем забрать токен
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),//хотим, чтобы в ответе на запрос нам дали токен
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        guard let url = urlComponents?.url else { return }//после того, что выше, создаем url из компонентов
        print(url)
        let request = URLRequest(url: url) //создаем запрос
        
        webView.load(request) //и обращаемся к нашей VK'еевой Вью с просьбой исполнить наш запрос
    }
    
    @objc func onPush () { //По долгому нажатию поле Name заполнится текстом "longPressGestureWorks"
        userNameTextField.text = "longPressGestureWorks"
    }
    
    // 7урок:сделаем перемигающие точки загрузки. Aнимация 3ех квадратных Вью (используем рекурсию) - перемигающие точки загрузки
    func loadingViewAnimation () {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.loadingThirdView.alpha = 0
            self?.loadingFirstView.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.loadingFirstView.alpha = 0
                self?.loadingSecondView.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 0.4) { [weak self] in
                    self?.loadingSecondView.alpha = 0
                    self?.loadingThirdView.alpha = 1
                } completion: { [weak self] _ in
                    self?.loadingViewAnimation()
                }
            }
        }
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 2) {
            let translationAppLabel = CGAffineTransform(translationX: 0, y: -140)
            
            let translationNameTitle = CGAffineTransform(translationX: -400, y: 0)
            let translationUserNameTextField = CGAffineTransform(translationX: -400, y: 0) //сместитьОтноcИсхТ.(origin)
            let translationPasswordtextField = CGAffineTransform(translationX: 500, y: 0)
            let translationPasswordTitle = CGAffineTransform(translationX: 500, y: 0)
            let translationTitleLabelView = CGAffineTransform(translationX: 0, y: -140)
            
            self.userNameTextField.transform = translationUserNameTextField //анимация перемещения
            self.passwordtextField.transform = translationPasswordtextField
            self.titleLabelView.transform = translationTitleLabelView
            self.nameTitle.transform = translationNameTitle
            self.passwordTitle.transform = translationPasswordTitle
            self.appLabel.transform = translationAppLabel
        }
        
        //Анимация слоя СALayer; пружиной (the spring effect) падает кнопка "Login"
        let springEffectToLoginButton = CASpringAnimation.init(keyPath: "position.y")
        springEffectToLoginButton.toValue  = 370 // финишная позицию
        springEffectToLoginButton.duration = 2.4 // сек
        springEffectToLoginButton.mass = 4
        springEffectToLoginButton.stiffness = 90 //
        springEffectToLoginButton.damping = 15 //затухание
        springEffectToLoginButton.initialVelocity = 5
        loginButton.layer.add(springEffectToLoginButton, forKey: nil)
        
        
        //        Storage.shared.friends = fillData() //8L1h50m в Storage записали Friendов
        
        loadingViewAnimation() //вызывается анимация перемигающих точек
        
        //задержка выполнения какого то кода
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) { [weak self] in
            self?.performSegue(withIdentifier: self?.toTabBarController ?? "", sender: nil)
        }
    }
}

//3.2.логика (Имплементируем делегат WKNavigationDelegate контроллеру и реализуем метод, который перехватывает ответы сервера при переходе: func webView)
extension LoginViewController: WKNavigationDelegate {
    
    func webView(// используем метод, кот. работает с навигацией
        _ webView: WKWebView,
        decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void
    ) {
        decisionHandler(.allow)//хендлер должен вызываться 1 раз (метод, с помощью кот.делаемПереход между страницами)
        
        guard
            let url = navigationResponse.response.url,// проверяет URL, на который было совершено перенаправление,
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
        
        let token = params["access_token"]
        
        print(token) //1ч после того как получили токен надо сделать перенаправление на какой-то экран
    }
}

