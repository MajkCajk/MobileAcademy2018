//
//  LoginFieldsVM.swift
//  6_week_homework
//
//  Created by Michal Chobola on 02.05.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit

class LoginFieldsVM {
    
    private let dataProvider: DataProviderType
    
    // MARK: closures
    public var emptyCredentials: (() -> Void)?
    public var sendCredentials: ((_ credentials: AccountCredentials?) -> Void)?
    
    //MARK: inits
    init(dataProvider: DataProviderType){
       self.dataProvider = dataProvider
    }
    
    // MARK: public mathods
    public func loadCredentials(name: String?, pass: String?){
        guard let input = name, let pass = pass, input.isEmpty == false, pass.isEmpty == false, pass == "etneteramobile", Reachability.isConnectedToNetwork() else {
            emptyCredentials?()
            return
        }
        dataProvider.getCredentials(loginText: name!, password: "etneteramobile"){
            [weak self] (credentials) in
            
            guard let credentials = credentials else{
                print("No credentials for this email and password")
                self?.emptyCredentials?()
                return
            }
            //save credentials in viewmodel of LoginLandingPageVC
            self?.sendCredentials?(credentials)
        }
    }
}
