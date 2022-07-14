
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
    
    var userToken: String? = "vk1.a.WBhaJ7L4PinDEzlvK0BlvyhqyfmEeEG9UfmTLJa7DVWkI3sLJ71722EdwboCTXTsGegtj2LSeBKWR93hMb_jgobjiPXh6vJygQP4UAkB8uPDTCwp2_YcZcNrb9Mn8IBxT_O66rfkBo8YH_gyBxfDc66arm6OZd-xNRdaoA25Uty2gi9Kjg-oYZmSivE4Fy1e"// поля с данными - задаем значения по умолчанию и
    var userId: Int? = 2906698 // и, когда нужно будет записать в них что-то далее в проекте, то :
}

// обращаемся к переменным из другого класса так:
//Session.sharedInstance.userId = "can write some value"
//print(Session.sharedInstance.userToken) //либо распечатать


//можно установить значение nil, if needed:
// var userToken: String? //опционал тут будет означать, что при выполнении запроса на получение данной инф ответа не последовало или выполнился ответ с ошибкой

//Singleton находится в оперативной памяти, а UserDefaults записывает на диск, потому немного медленнее, но может хранить инфо между перезапусками МП (там можно сохранить временные покупки, а логин и пароль - в keyChain).Core Data изучить досконально
