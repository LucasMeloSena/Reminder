//
//  LoginBottomSheetView.swift
//  Reminder
//
//  Created by Lucas Sena on 13/03/25.
//

import Foundation
import UIKit

class LoginBottomSheetView: UIView {
    public weak var delegate: LoginBottomSheetViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "login.bottom.sheet.label")
        label.textColor = .black
        label.font = Typography.subHeading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "email.form.label")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = String(localized: "email.placeholder")
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "password.form.label")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = String(localized: "password.placeholder")
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String(localized: "login.button.title"), for: .normal)
        button.backgroundColor = Colors.primaryRedBase
        button.tintColor = .white
        button.layer.cornerRadius = Metrics.medium
        button.titleLabel?.font = Typography.subHeading
        button.addTarget(self, action: #selector(loginButtonDidTaped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = Metrics.small
        
        self.addSubview(titleLabel)
        self.addSubview(emailLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        
        setupConstraints()
        setupDelegates()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.huge),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.huge),
            emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -Metrics.small),
            
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.medium),
            emailTextField.heightAnchor.constraint(equalToConstant: Metrics.inputSize),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Metrics.medium),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -Metrics.small),
            
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.medium),
            passwordTextField.heightAnchor.constraint(equalToConstant: Metrics.inputSize),
            
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.huge),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.medium),
            loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize)
        ])
    }
    
    @objc
    private func loginButtonDidTaped() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        delegate?.sendLoginData(email: email, password: password)
    }
    
    private func setupDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
}

extension LoginBottomSheetView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
