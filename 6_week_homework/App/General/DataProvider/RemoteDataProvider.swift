//
//  RemoteDataProvider.swift
//  4_week_homework
//
//  Created by Michal Chobola on 29.04.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import Foundation
//MARK: protocol
protocol RemoteDataProviderType: DataProviderType {
    var baseUrl: String { get }
    func getUrl(for endpoint: Endpoint) -> URL
}
extension RemoteDataProviderType {
    var baseUrl: String {
        return "http://emarest.cz.mass-php-1.mit.etn.cz"
    }
    func getUrl(for endpoint: Endpoint) -> URL {
        return URL(string: baseUrl + endpoint.rawValue)!
    }
    func getUrl(for endpoint: Endpoint, with id: Int) -> URL {
        return URL(string: baseUrl + endpoint.rawValue + "/" + String(id))!
    }
}

class RemoteDataProvider: RemoteDataProviderType {
    
    //MARK: public functions
    public func login(email: String, password: String, completion: @escaping (AccountCredentials?) -> Void) {
        let url = getUrl(for: .login)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let dataEncode = try? encoder.encode(Login(email, password))
        urlRequest.httpBody = dataEncode
        
        URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            
            let decoder = JSONDecoder()
            let model = try? decoder.decode(AccountCredentials.self, from: data!)
            
            DispatchQueue.main.async {
                completion(model)
            }
            
            }.resume()
    }
    public func getCredentials(loginText: String, password: String, completion: @escaping (AccountCredentials?) -> Void) {
        let url = getUrl(for: .login)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let login = Login(loginText, password)
        let encodedData = try? encoder.encode(login)
        urlRequest.httpBody = encodedData
        
        let session = URLSession.shared
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            let content = data
            let decoder = JSONDecoder()
            let model = try? decoder.decode(AccountCredentials.self, from: content!)
            
            DispatchQueue.main.sync {
                completion(model)
            }
        }.resume()
    }
    
    public func completeLogin(credentials: AccountCredentials, completion: @escaping (_ Participant: Participant?) -> Void){
        let url = URL(string: baseUrl + Endpoint.account.rawValue + "/" + String(credentials.accountId))!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(credentials.accessToken, forHTTPHeaderField: "accessToken")
        
        let session = URLSession.shared
        session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            let content = data
            let decoder = JSONDecoder()
            let model = try? decoder.decode(Participant.self, from: content!)
            
            DispatchQueue.main.async {
                completion(model)
            }
            }.resume()
    }
    
    public func loadParticipants(completion: @escaping (_ participants: [Participant]?) -> Void) {
        let url = getUrl(for: .participants)

        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            let decoder = JSONDecoder()
            let model = try? decoder.decode([Participant].self, from: data!)
            
            DispatchQueue.main.async {
                completion(model)
            }
            }.resume()
    }
    
    public func loadParticipant(id: Int, completion: @escaping (_ participant: Participant?) -> Void) {
        let url = getUrl(for: .participant, with: id)
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            let decoder = JSONDecoder()
            let model = try? decoder.decode(Participant.self, from: data!)
            
            DispatchQueue.main.async {
                completion(model)
            }
            }.resume()
    }
}
