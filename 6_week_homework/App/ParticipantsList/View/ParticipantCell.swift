//
//  ParticipantCell.swift
//  5_week_homework
//
//  Created by Michal Chobola on 01.05.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//
// MARK: - Cell

import UIKit
import Kingfisher
class ParticipantCell: UITableViewCell {
    
    //MARK: inits
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: public functions
    public func customize(with participant: ParticipantType) {
        if(participant.imageUrl?.isEmpty == false){
            self.imageView?.image = nil
            let imageUrl = URL(string: participant.imageUrl!)
            // download image
            self.imageView?.kf.setImage(with: imageUrl){ _, _, _, _ in
                self.setNeedsLayout()
            }
        }
        else{ //only mock data are available
            self.imageView?.image = UIImage(named: participant.icon)
        }
        self.textLabel?.text = participant.name
//        self.imageView?.image = UIImage(named: participant.icon)
        self.detailTextLabel?.attributedText = participant.scores.sorted(by: { lhs, rhs in
            lhs.value > rhs.value
        })[0..<min(4, participant.scores.count)]
            .filter {
                $0.value > 0
            }
            .reduce(NSMutableAttributedString()) { accum, current in
                accum.append(NSAttributedString(string: current.emoji, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 24)]))
                accum.append(NSAttributedString(string: " \(current.value)   ", attributes: [
                    NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13),
                    NSAttributedStringKey.baselineOffset: 2,
                    NSAttributedStringKey.foregroundColor: UIColor.gray
                    ]))
                return accum
        }
    }
}
