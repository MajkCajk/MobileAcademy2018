//
//  DataProviderType.swift
//  6_week_homework
//
//  Created by Michal Chobola on 02.05.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import Foundation
//MARK: enum
enum Endpoint: String {
    case participants = "/api/participants?sort=asc"
    case login = "/api/login"
    case participant = "/api/participant"
    case account = "/api/account"
}
//MARK: protocol
protocol DataProviderType {
    func login(email: String, password: String, completion: @escaping (_ accountCredentials: AccountCredentials?) -> Void)
    func completeLogin(credentials: AccountCredentials, completion: @escaping (_ Participant: Participant?) -> Void)
    func loadParticipant(id: Int, completion: @escaping (_ participant: Participant?) -> Void)
    func loadParticipants(completion: @escaping (_ participants: [Participant]?) -> Void)
    func getCredentials(loginText: String, password: String, completion: @escaping (AccountCredentials?) -> Void)

}
extension DataProviderType {
    
    //MARK: private functions
    private func renameScores(for participant: ParticipantType) -> [ScoreType]{
        let namedScores = participant.scores.map { (oldScore: ScoreType) -> ScoreType in
            Score(emoji: "\(oldScore.emoji) skóre", value: oldScore.value)
        }
        return namedScores
    }
    //MARK: public functions
    public func getBusinessCard(for participant: Participant) -> BusinessCardContent {
        let namedScores = renameScores(for: participant)
        
        return BusinessCardContent(
            photoName: "\(participant.icon)-large",
            photoUrl: participant.imageUrl!,
            name: participant.name,
            slackUserId: participant.slack_id ?? "1234",
            email: participant.email ?? "random@email.com",
            phone: participant.phone ?? "777123456",
            position: participant.position ?? "Swift ninja junior",
            scores: namedScores
            )
    }
}

