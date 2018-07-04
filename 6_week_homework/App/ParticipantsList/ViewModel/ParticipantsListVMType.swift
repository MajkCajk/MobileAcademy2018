//
//  ParticipantsListVMType.swift
//  5_week_homework
//
//  Created by Michal Chobola on 01.05.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit
protocol ParticipantsListVMType {
    typealias Section = (header: String?, rows: [Row], footer: String?)
    typealias Model = [Section]
    
    var model: Model { get }
    var didUpdateModel: ((Model) -> Void)? { get set }
    
    func numberOfSections() -> Int
    func numberOfRows(inSection: Int) -> Int
    func modelForSection(_ section: Int) -> Section
    func modelForRow(inSection: Int, atIdx: Int) -> Row
}

extension ParticipantsListVMType {
    func numberOfSections() -> Int {
        return model.count
    }
    
    func numberOfRows(inSection: Int) -> Int {
        return model[inSection].rows.count
    }
    
    func modelForSection(_ section: Int) -> ParticipantsListVM.Section {
        return model[section]
    }
    
    func modelForRow(inSection: Int, atIdx: Int) -> Row {
        return model[inSection].rows[atIdx]
    }
}
