
//  Singleton.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 11.07.2022.
//

import Foundation
//31m Живет в рамках одной сессии (пока живет приложение)
class Session {
    private init() {}//чтобы класс был в 1ом экземпляре: создаем конструктор и запрещаем к нему доступ извне - т.е. создать экземпляр класса можно только внутри класса или структуры (зависит от цели). Классом лучше, тк нет копирования как в структуре
    
    static let sharedInstance = Session() //чтобы получить доступность извне. Когда МП запускается, то происходит обход статичных полей и присваивание им значений - так ему ставится 1 значение и мы можем всегда пользоваться полями с данными
    
    var userToken: String? = "vk1.a.YOMnJnoQRMmaI-yqFYAdNVAGb8jdqAoe6TWPs5DhNVicw_okY4Q7Lzid4FUpobsTWhu3l57PwBTqMvdjZsr4BRxmW2uINk3vG1REYGpVSdlHtk3K3tbwDW1hDt0SKuhdaq66PGh_WxsDH2FVBoLhVo8_zV28W842Af4T4VSRhZNzx9TyV6mfrvLQg2GSY4D3"// поля с данными - задаем значения по умолчанию и
    var userId: Int? = 2906698 // и, когда нужно будет записать в них что-то далее в проекте, то :
}

// обращаемся к переменным из другого класса так:
//Session.sharedInstance.userId = "can write some value"
//print(Session.sharedInstance.userToken) //либо распечатать


//можно установить значение nil, if needed:
// var userToken: String? //опционал тут будет означать, что при выполнении запроса на получение данной инф ответа не последовало или выполнился ответ с ошибкой

//Singleton находится в оперативной памяти, а UserDefaults записывает на диск, потому немного медленнее, но может хранить инфо между перезапусками МП (там можно сохранить временные покупки, а логин и пароль - в keyChain).Core Data изучить досконально
