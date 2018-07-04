//
//  Participant.swift
//  4_week_homework
//
//  Created by Michal Chobola on 13.04.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import Foundation
//MARK: protocol
public protocol ParticipantType: Decodable {
    var id: Int { get }
    var name: String { get }
    var icon: String { get }
    var imageUrl: String? { get }
    var throttledImageUrl: String? { get }
    var scores: [Score] { get }
}

class Participant: ParticipantType {
    //MARK: public vars
    public var id: Int
    public var name: String
    public var icon: String
    public var imageUrl: String?
    public var throttledImageUrl: String?
    public var slack_id: String?
    public var email: String?
    public var phone: String?
    public var position: String?
    public var scores: [Score]
    
    //MARK: inits
    public init(id: Int, name: String, icon: String, imageUrl: String? = nil, throttledImageUrl: String? = nil, scores: [Score], slack_id: String? = nil,
                email: String? = nil, phone: String? = nil, position: String? = nil) {
        self.id = id
        self.name = name
        self.icon = icon
        self.imageUrl = imageUrl
        self.throttledImageUrl = throttledImageUrl
        self.scores = scores

        self.slack_id = slack_id
        self.email = email
        self.phone = phone
        self.position = position
    }
}
