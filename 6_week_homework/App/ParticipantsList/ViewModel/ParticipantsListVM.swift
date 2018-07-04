//
//  File.swift
//  5_week_homework
//
//  Created by Michal Chobola on 01.05.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit
class ParticipantsListVM: ParticipantsListVMType {
    private(set) var model: [ParticipantsListVMType.Section] = [] {
        didSet {
            didUpdateModel?(model)
        }
    }
    private let dataProvider: DataProviderType
    
    var didUpdateModel: ((Model) -> Void)?
    var waiting: (() -> Void)?
    var stopWaiting: (() -> Void)?
    
    init(with dataProvider: DataProviderType) {
        self.dataProvider = dataProvider
    }
    
    func loadData( ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            if(self.model.count == 0){
                self.waiting?()
            }
        }
        
        RemoteDataProvider().loadParticipants {
            [weak self] (participants) in
            
            self?.stopWaiting?()
            guard let participantsTmp = participants else {
                print("Loading participants has failed.")
                return
            }
            let participants = participantsTmp.map {
                Row.participant($0)
            }
            self?.model = [Section(header: "", rows: participants, footer: "")]
        }
    }
}


