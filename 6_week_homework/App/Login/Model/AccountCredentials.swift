//
//  AccountCredentials.swift
//  4_week_homework
//
//  Created by Michal Chobola on 13.04.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import Foundation
class AccountCredentials: Decodable {
    let accountId: Int
    let accessToken: String
    
    init(accountId: Int, accessToken: String) {
        self.accountId = accountId
        self.accessToken = accessToken
    }
}

extension AccountCredentials: CustomStringConvertible {
    var description: String {
        return "accountId: \(accountId), accessToken: \(accessToken)"
    }
}
