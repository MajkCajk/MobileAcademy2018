//
//  Login.swift
//  4_week_homework
//
//  Created by Michal Chobola on 13.04.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import Foundation
class Login: Encodable {
    let email: String
    let password: String
    
    init(_ email: String,_ password: String) {
        self.email = email
        self.password = password
    }
}
