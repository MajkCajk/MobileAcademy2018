//
//  BusinessCardVM.swift
//  6_week_homework
//
//  Created by Michal Chobola on 02.05.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import Foundation
class BusinessCardVM {
    
    //MARK: private vars
    private var credentials: AccountCredentials?
    private var participantId: Int? = nil
    private var dataProvider: DataProviderType
    
    //MARK: closures
    var load: ((_ content: BusinessCardContent) -> Void)?
    
    //MARK: inits
    init(with dataProvider: DataProviderType, with credentials: AccountCredentials){
        self.credentials = credentials
        self.dataProvider = dataProvider
    }
    
    init(with dataProvider: DataProviderType, with id: Int){
        self.participantId = id
        self.dataProvider = dataProvider
    }
    
    //MARK: public methods
    public func loadParticipant(){
        if(participantId != nil){
            loadParticipantWithId()
        }
        else if(credentials != nil){
            loadParticipantWithCredendials()
        }
    }
    
    //MARK: private methods
    private func loadParticipantWithCredendials(){
        
        dataProvider.completeLogin(credentials: self.credentials!){
            [weak self] (participant) in
            
            guard let participant = participant else {
                print("Loading of the participant with these credentials has failed.")
                return
            }
            let content = self?.dataProvider.getBusinessCard(for: participant)
            
            self?.load?(content!)
        }
    }
    
    private func loadParticipantWithId(){
        
        dataProvider.loadParticipant(id: participantId!) {
            [weak self] (participant) in
            
            guard let participant = participant else {
                print("Loading of this participant has failed.")
                return
            }
            let participantContent = self?.dataProvider.getBusinessCard(for: participant)
            
            self?.load?(participantContent!)
        }
    }
}
