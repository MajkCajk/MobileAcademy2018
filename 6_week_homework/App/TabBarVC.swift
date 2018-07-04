//
//  TabBarVC.swift
//  3_week_homework
//
//  Created by Michal Chobola on 03.04.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//
import UIKit
class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: private vars
    private lazy var participansListView = makeParticipansListView()
    private lazy var loginView = makeLoginView()

    //MARK: view methods
    override func loadView() {
        super.loadView()
        self.tabBar.tintColor = UIColor(named: "academy")
        self.viewControllers = [participansListView, loginView]
    }
    
    override func viewDidLoad() {
        self.delegate = self
    }
    
    //MARK: private funcs
    private func makeLoginView() -> UINavigationController {
        let loginBtnVC = LoginBtnVC(viewModel: LoginBtnVM())
        let loginViewController = UINavigationController(rootViewController: loginBtnVC)
        loginViewController.tabBarItem = UITabBarItem(title: "Účet", image: UIImage(named: "ic-account"), selectedImage: UIImage(named: "ic-account"))
        loginViewController.navigationBar.tintColor = UIColor(named: "academy")
        return loginViewController
    }
    private func makeParticipansListView() -> UINavigationController {
        let participantsListVC = ParticipantsListVC(viewModel: ParticipantsListVM(with: RemoteDataProvider()))
        let participansListController = UINavigationController(rootViewController: participantsListVC)
        participantsListVC.tabBarItem = UITabBarItem(title: "Seznam účastníků", image: UIImage(named: "ic-list"), selectedImage: UIImage(named: "ic-list"))
        participansListController.navigationBar.tintColor = UIColor(named: "academy")
        return participansListController
    }
    // if TabBarItem was selected again and there is no action needed
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
