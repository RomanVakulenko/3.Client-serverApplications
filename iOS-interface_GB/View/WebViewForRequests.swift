//
//  Requests.swift
//  2ndLesson
//
//  Created by Roman Vakulenko on 14.07.2022.
//

import Foundation
import UIKit

class SecondViewShowingTheResultOfWebRequests: UIViewController {
    
    //создадим экземпляр класса, чтобы когда экран 2ого ВьюК загрузится вызвать его методы - ниже
    var requests = Requests()
    
    override func viewDidLoad () {
        super.viewDidLoad()
        
        requests.getFriendsDataAndParseIt()
        requests.getUsersDataAndParseIt()
        requests.getUserGroupsDataAndParseIt()
    }
}


