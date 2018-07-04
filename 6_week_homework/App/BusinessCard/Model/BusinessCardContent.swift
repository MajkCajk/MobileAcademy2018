//
//  BusinessCardContent.swift
//  firstapp
//
//  Created by Jan Čislinský on 21. 03. 2018.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import Foundation

public class BusinessCardContent {
    public let photoName: String
    public let photoUrl: String
    public let name: String
    public let slackUserId: String
    public let email: String
    public let phone: String
    public let position: String
    public let scores: [ScoreType]
    
    public init(photoName: String, photoUrl: String, name: String, slackUserId: String, email: String, phone: String, position: String, scores: [ScoreType]) {
        self.photoName = photoName
        self.photoUrl = photoUrl
        self.name = name
        self.slackUserId = slackUserId
        self.email = email
        self.phone = phone
        self.position = position
        self.scores = scores
    }
}
