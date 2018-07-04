//
//  TextFieldVC.swift
//  firstapp
//
//  Created by Michal Chobola on 24.03.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit
import LocalAuthentication
class LoginBtnVC: UIViewController {
    
    private lazy var buttonTextField: UIButton = makeButton()
    private let viewModel: LoginBtnVM
    
    init(viewModel: LoginBtnVM){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(buttonTextField)
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        enableViews()
    }
    
    private func makeButton() -> UIButton {
        let v = UIButton()
        v.setTitle("Přihlásit", for: .normal)
        v.backgroundColor = UIColor(named: "academy")
        v.layer.cornerRadius = 6
        v.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .highlighted)
        
        v.addTarget(self, action: #selector(LoginBtnVC.press), for: .touchUpInside)
        return v
    }
    @objc private func press() {
        disableViews()
        if(viewModel.hasCredentials()){
            biometricsLogin()
        } else {
            self.presentLoginFieldsVC()
        }
    }
    private func enableViews(){
        buttonTextField.isEnabled = true
    }
    
    private func disableViews(){
        buttonTextField.isEnabled = false
    }
    func biometricsLogin() {
        let myContext = LAContext()
        let myLocalizedReasonString = "Personal data are confidential."
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    if success {
                        // User authenticated successfully
                        self.pushBusinessCardVC(with: self.viewModel.getCredentials()!)
                    } else {
                        // User did not authenticate successfully
                        print("Not authenticate successfully.")
                        self.presentLoginFieldsVC()
                    }
                }
            } else {
                // Could not evaluate policy
                print("Biometrics is probably disabled.")
                self.presentLoginFieldsVC()
            }
        } else {
            print("At least OS 8.0 is needed.")
            self.presentLoginFieldsVC()
        }
    }
    func presentLoginFieldsVC() {
        let viewModel = LoginFieldsVM(dataProvider: RemoteDataProvider())
        let loginFieldsVC = LoginFieldsVC(viewModel: viewModel)
        bindViewWithModel(viewModel, loginFieldsVC)
        
        self.present(loginFieldsVC, animated: true)
    }
    func pushBusinessCardVC(with credentials: AccountCredentials) {
        DispatchQueue.main.async{
            let businessCardVM = BusinessCardVM(with: RemoteDataProvider(), with: credentials)
            let businessCardVC = BusinessCardVC(with: businessCardVM)
            self.navigationController?.pushViewController(businessCardVC, animated: false)
        }
    }
    func bindViewWithModel(_ loginVM: LoginFieldsVM,_ loginVC: LoginFieldsVC){
        loginVM.sendCredentials = { [weak self] (credentials) in
            self?.viewModel.setCredentials(with: credentials)
            if(credentials != nil){
                // create and push business card viewcontroller after the animation of dismissing
                loginVC.dismiss(animated: true, completion: {
                    self?.disableViews()
                    self?.pushBusinessCardVC(with: credentials!)
                })
            }
        }
    }
    
    private func setupConstraints() {
        buttonTextField.translatesAutoresizingMaskIntoConstraints = false
        buttonTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonTextField.widthAnchor.constraint(equalToConstant: buttonTextField.intrinsicContentSize.width + 2 * 20).isActive = true
        buttonTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
}
