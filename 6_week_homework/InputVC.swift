//
//  InputVC.swift
//  firstapp
//
//  Created by Jan Čislinský on 21. 03. 2018.
//  Copyright © 2018 Etnetera, a. s. All rights reserved.
//

import UIKit

class InputVC: UIViewController {
    private lazy var inputTextField: UITextField = makeInput()
    private lazy var button: UIButton = makeButton()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        inputTextField.becomeFirstResponder()
    }

    override func loadView() {
        super.loadView()
        view.addSubview(inputTextField)
        view.addSubview(button)
        setupConstraints()
    }

    private func setupConstraints() {
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputTextField.widthAnchor.constraint(equalTo: view.readableContentGuide.widthAnchor).isActive = true
        inputTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true

        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: button.intrinsicContentSize.width + 2 * 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private func makeInput() -> UITextField {
        let v = UITextField()
        v.placeholder = "Vlož jméno"
        v.textAlignment = .center
        v.tintColor = UIColor(named: "academy")
        v.borderStyle = .roundedRect
        v.keyboardType = .asciiCapable
        v.returnKeyType = .go
        return v
    }

    private func makeButton() -> UIButton {
        let v = UIButton()
        v.setTitle("Uložit", for: .normal)
        v.backgroundColor = UIColor(named: "academy")
        v.layer.cornerRadius = 6
        v.setTitleColor(UIColor.white.withAlphaComponent(0.6), for: .highlighted)

        v.addTarget(self, action: #selector(InputVC.press), for: .touchUpInside)
        return v
    }

    @objc private func press() {
        inputTextField.resignFirstResponder()
        print("\(inputTextField.text ?? "–")")

        if let input = inputTextField.text, input.isEmpty == false {
            UserDefaults.standard.set(input, forKey: "selectedUser")
            navigationController?.pushViewController(ParticipantsListVC(viewModel: ViewModel()), animated: true)
        }
    }
}
