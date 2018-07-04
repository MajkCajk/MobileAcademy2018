//
//  ViewController.swift
//  firstapp
//
//  Created by Jan Čislinský on 21. 03. 2018.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit

class BusinessCardVC: UIViewController {
    
    //MARK: private vars
    private let cardView = BusinessCardView()
    private let viewModel: BusinessCardVM

    //MARK: inits
    init(with viewModel: BusinessCardVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.addSubview(cardView)
        cardView.frame = view.bounds
        cardView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        viewModel.loadParticipant()
    }
    
    //MARK: private methods
    private func bindViewModel(){
        viewModel.load = { [weak self] cardContent  in
            self?.setCardViewContent(content: cardContent)
        }
    }
    
    //MARK: public methods
    public func setCardViewContent(content: BusinessCardContent){
        cardView.content = content
    }
}
