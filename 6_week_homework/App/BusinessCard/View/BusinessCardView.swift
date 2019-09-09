//
//  BusinessCardView.swift
//  firstapp
//
//  Created by Jan Čislinský on 21. 03. 2018.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit

private let displayPadding: CGFloat = 30
private let buttonHeight: CGFloat = 44
private let spacing: (low: CGFloat, mid: CGFloat, high: CGFloat) = (10, 20, 40)
        let fontSize: (medium: CGFloat, large: CGFloat, xLarge: CGFloat) = (14, 18, 24)

class BusinessCardView: UIScrollView {

    //MARK: public vars
    var content: BusinessCardContent? {
        didSet {
            setupContent()
        }
    }
    
    //MARK: closures
    private var slackButtonTapped: (()->Void)?

    // MARK: private vars
    private lazy var loadingView: UIActivityIndicatorView = self.makeLoadingView()
    private lazy var stackView: UIStackView = UIStackView()
    private lazy var avatarImageView: UIImageView = self.makeAvatarImageView()
    private lazy var nameLabel: UILabel = self.makeNameLabel()
    private lazy var slackButton: UIButton = self.makeSlackButton()
    private lazy var emailButton: UIButton = self.makeEmailButton()
    private lazy var phoneButton: UIButton = self.makePhoneButton()
    private lazy var positionLabel: UILabel = self.makePositionLabel()
    private lazy var separator: UIView = self.makeSeparatorView()
    private lazy var scoresViews: [ScoreView] = self.makeScoresViews()

    // MARK: inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: private functions
    private func setupContent() {
        if let content = content {
            setupContent(content)
        } else {
            setupEmptyContent()
        }
        bindViewModel()
    }
    private func bindViewModel() {
        slackButton.add { [unowned self] _ in
            self.slackButtonTapped?()
        }
    
    }
    private func setupEmptyContent() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingView.startAnimating()
    }

    private func setupContent(_ content: BusinessCardContent) {
        loadingView.stopAnimating()
        loadingView.removeFromSuperview()

        if stackView.superview == nil {
            let contactStackView = UIStackView()
            contactStackView.alignment = .center
            contactStackView.axis = .horizontal
            contactStackView.spacing = spacing.low

            [slackButton, emailButton, phoneButton].forEach {
                contactStackView.addArrangedSubview($0)
            }

            addSubview(stackView)
            stackView.alignment = .center
            stackView.axis = .vertical
            stackView.spacing = spacing.mid

            [avatarImageView, nameLabel, contactStackView, positionLabel, separator].forEach {
                stackView.addArrangedSubview($0)
            }
            scoresViews.forEach {
                stackView.addArrangedSubview($0)
                stackView.setCustomSpacing(spacing.low, after: $0)
            }
            stackView.setCustomSpacing(spacing.high, after: nameLabel)

            setupConstratins()
        }
        updateContent(content)
    }

    private func setupConstratins() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 2 * spacing.high).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.widthAnchor.constraint(equalToConstant: 2 * avatarImageView.layer.cornerRadius).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true

        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -2 * displayPadding).isActive = true

        scoresViews.forEach { rowView in
            rowView.translatesAutoresizingMaskIntoConstraints = false
            rowView.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
            rowView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -2 * displayPadding).isActive = true
        }
    }

    private func updateContent(_ content: BusinessCardContent) {
        if(content.photoUrl != ""){
            let imageUrl = URL(string: content.photoUrl)
            // downloading image with Kingfisher
            avatarImageView.kf.setImage(with: imageUrl){ _, _, _, _ in
                self.setNeedsLayout()
            }
        }
        else{
            avatarImageView.image = UIImage(named: content.photoName)
        }
        nameLabel.text = content.name
        positionLabel.text = content.position
        zip(scoresViews, content.scores).forEach {
            $0.0.content = $0.1
        }
    }
    //MARK: view functions
    override func layoutSubviews() {
        super.layoutSubviews()
        [slackButton, emailButton, phoneButton].forEach {
            $0.centerVertically()
        }
    }

    // MARK: views builders
    private func makeLoadingView() -> UIActivityIndicatorView {
        let rVal = UIActivityIndicatorView()
        rVal.style = .gray
        return rVal
    }

    private func makeAvatarImageView() -> UIImageView {
        let rVal = UIImageView()
        rVal.contentMode = .scaleAspectFit
        rVal.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        rVal.layer.borderWidth = 1
        rVal.layer.cornerRadius = 75
        return rVal
    }

    private func makeNameLabel() -> UILabel {
        let rVal = UILabel()
        rVal.font = .systemFont(ofSize: fontSize.xLarge)
        return rVal
    }

    private func makeButton() -> UIButton {
        let rVal = UIButton()
        rVal.setTitleColor(.black, for: .normal)
        rVal.setTitleColor(UIColor.black.withAlphaComponent(0.6), for: .highlighted)
        rVal.titleLabel?.font = .systemFont(ofSize: fontSize.medium)
        return rVal
    }

    private func makeSlackButton() -> UIButton {
        let rVal = makeButton()
        rVal.setTitle("Slack", for: .normal)
        rVal.setImage(UIImage(named: "ic-slack"), for: .normal)
        return rVal
    }

    private func makeEmailButton() -> UIButton {
        let rVal = makeButton()
        rVal.setTitle("E-mail", for: .normal)
        rVal.setImage(UIImage(named: "ic-email"), for: .normal)
        return rVal
    }

    private func makePhoneButton() -> UIButton {
        let rVal = makeButton()
        rVal.setTitle("Telefon", for: .normal)
        rVal.setImage(UIImage(named: "ic-phone"), for: .normal)
        return rVal
    }

    private func makePositionLabel() -> UILabel {
        let rVal = UILabel()
        rVal.font = .boldSystemFont(ofSize: fontSize.large)
        return rVal
    }

    private func makeSeparatorView() -> UIView {
        let rVal = UIView()
        rVal.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return rVal
    }

    private func makeScoresViews() -> [ScoreView] {
        return content?.scores.map { _ in
            ScoreView()
            } ?? []
    }
}


