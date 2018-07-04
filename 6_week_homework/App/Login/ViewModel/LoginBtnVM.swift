//
//  LoginBtnVM.swift
//  6_week_homework
//
//  Created by Michal Chobola on 02.05.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit

class LoginBtnVM {
    
    //MARK: private vars
    private var credentials: AccountCredentials? = nil
    
    //MARK: public functions
    public func hasCredentials() -> Bool{
        if UserDefaults.standard.value(forKeyPath: "accountId") != nil {
            let accountId = UserDefaults.standard.value(forKeyPath: "accountId") as! Int
            let accessToken = UserDefaults.standard.value(forKeyPath: "accessToken") as! String
            credentials = AccountCredentials(accountId: accountId, accessToken: accessToken)
        }
        return credentials != nil
    }
    public func setCredentials(with credentials: AccountCredentials?){
        self.credentials = credentials
        UserDefaults.standard.set(credentials?.accountId, forKey: "accountId")
        UserDefaults.standard.set(credentials?.accessToken, forKey: "accessToken")
    }
    public func getCredentials() -> AccountCredentials?{
        return credentials
    }
}
