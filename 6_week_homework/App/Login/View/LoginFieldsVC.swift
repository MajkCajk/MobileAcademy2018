//
//  TextFieldVC.swift
//  firstapp
//
//  Created by Michal Chobola on 24.03.18.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit

class LoginFieldsVC: UIViewController, UITextFieldDelegate {
    
    private lazy var nameField: UITextField = nameFieldMake()
    private lazy var passwordField: UITextField = passwordFieldMake()
    private lazy var buttonTextField: UIButton = makeButton()
    
    private var businessCardVC: BusinessCardVC?
    private var viewModel: LoginFieldsVM
    
    init(viewModel: LoginFieldsVM){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(nameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(buttonTextField)
        setupConstraints()
        bindViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        nameField.becomeFirstResponder()
    }
    
    func bindViewModel() {
        viewModel.emptyCredentials = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func nameFieldMake() -> UITextField{
        let tf = UITextField()
        tf.placeholder = "Vlož přihlašovací jméno"
        tf.textAlignment = .center
        tf.tintColor = UIColor(named: "academy")
        tf.borderStyle = .roundedRect
        tf.keyboardType = .asciiCapable
        tf.returnKeyType = .next
//        tf.tag = 0
        tf.delegate = self
        return tf
    }
    
    private func passwordFieldMake() -> UITextField{
        let tf = UITextField()
        tf.placeholder = "Heslo"
        tf.textAlignment = .center
        tf.tintColor = UIColor(named: "academy")
        tf.borderStyle = .roundedRect
        tf.keyboardType = .asciiCapable
        tf.returnKeyType = .go
        tf.isSecureTextEntry = true
//        tf.tag = 1
        tf.delegate = self
        return tf
    }
    
    private func makeButton() -> UIButton {
        let v = UIButton()
        v.setTitle("Přihlásit", for: .normal)
        v.backgroundColor = UIColor(named: "academy")
        v.layer.cornerRadius = 6
        v.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .highlighted)
        
        v.addTarget(self, action: #selector(LoginFieldsVC.press), for: .touchUpInside)
        return v
    }
    private func enableViews(){
        buttonTextField.isEnabled = true
        nameField.isEnabled = true
        passwordField.isEnabled = true
    }
    
    private func disableViews(){
        buttonTextField.isEnabled = false
        nameField.isEnabled = false
        passwordField.isEnabled = false
    }
    @objc private func press() {
        nameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        disableViews()
        
        viewModel.loadCredentials(name: nameField.text, pass: passwordField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == nameField){
            nameField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        }else if(textField == passwordField){
            passwordField.resignFirstResponder()
            self.press()
        }
        return true
    }
    
    private func setupConstraints() {
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameField.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: view.readableContentGuide.widthAnchor).isActive = true
        nameField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalTo: view.readableContentGuide.widthAnchor).isActive = true
        passwordField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        passwordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20).isActive = true
        
        buttonTextField.translatesAutoresizingMaskIntoConstraints = false
        buttonTextField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        buttonTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonTextField.widthAnchor.constraint(equalToConstant: buttonTextField.intrinsicContentSize.width + 2 * 20).isActive = true
        buttonTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
}

