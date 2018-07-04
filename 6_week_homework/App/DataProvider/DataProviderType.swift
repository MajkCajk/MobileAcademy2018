//
//  DataProviderType.swift
//  4_week_homework
//
//  Created by Michal Chobola on 13.04.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import Foundation
protocol DataProviderType {
    func loadParticipants(completion: @escaping (_ participants: [Participant]?) -> Void)
    func login(email: String, password: String, completion: @escaping (_ accountCredentials: AccountCredentials?) -> Void)
    func loadParticipant(id: Int, completion: @escaping (_ participant: ParticipantDetail?) -> Void)
}
