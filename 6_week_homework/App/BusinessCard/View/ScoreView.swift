//
//  ScoreView.swift
//  5_week_homework
//
//  Created by Michal Chobola on 01.05.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit
class ScoreView: UIView {
    
    // MARK: public vars
    public var content: ScoreType? {
        didSet {
            setupContent()
        }
    }
    
    // MARK: private
    private lazy var leftLabel: UILabel = self.makeLeft()
    private lazy var rightLabel: UILabel = self.makeRight()
    
    // MARK: private functions
    private func setupContent() {
        if subviews.isEmpty {
            addSubview(leftLabel)
            addSubview(rightLabel)
            
            leftLabel.translatesAutoresizingMaskIntoConstraints = false
            leftLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            rightLabel.translatesAutoresizingMaskIntoConstraints = false
            rightLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor).isActive = true
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
        updateContent()
    }
    
    private func updateContent() {
        leftLabel.text = content?.emoji ?? ""
        rightLabel.text = String(content?.value ?? 0)
    }
    
    private func makeLeft() -> UILabel {
        let rVal = UILabel()
        rVal.font = .systemFont(ofSize: fontSize.medium)
        return rVal
    }
    
    private func makeRight() -> UILabel {
        let rVal = UILabel()
        rVal.font = .boldSystemFont(ofSize: fontSize.medium)
        rVal.textAlignment = .right
        return rVal
    }
}
