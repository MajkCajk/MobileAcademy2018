//
//  Score.swift
//  4_week_homework
//
//  Created by Michal Chobola on 13.04.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import Foundation
// MARK: - Score

public protocol ScoreType: Decodable {
    var value: Int { get }
    var emoji: String { get }
}
public class Score: ScoreType {
    
    //MARK: public vars
    public var value: Int
    public var emoji: String
    public var name: String?
    
    //MARK: inits
    public init(emoji: String, value: Int, name: String? = nil) {
        self.value = value
        self.emoji = emoji
        self.name = name
    }
}
