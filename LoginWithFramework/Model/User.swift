//
//  User.swift
//  LoginWithFramework
//
//  Created by Administrator on 11/27/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import Foundation

struct User {
    var name, email, avata, age: String?
    
    init(name: String = "", avata: String = "", email: String = "", age: String = "") {
        self.name = name
        self.email = email
        self.avata = avata
        self.age = age
    }
}
