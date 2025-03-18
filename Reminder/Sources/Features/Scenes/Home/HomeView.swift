//
//  HomeView.swift
//  Reminder
//
//  Created by Lucas Sena on 14/03/25.
//

import Foundation
import UIKit

class HomeView: UIView {
    public weak var delegate: HomeViewDelegate?
    
    let profileBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Metrics.medium 
        view.layer.masksToBounds = true
        view.backgroundColor = Colors.gray800
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = Metrics.medium
        image.image = UIImage(named: "user")
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "home.welcome.label")
        label.textColor = Colors.gray200
        label.font = Typography.input
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = Colors.gray100
        textField.font = Typography.heading
        textField.placeholder = String(localized: "home.username.input")
        textField.returnKeyType = .done
        textField.addTarget(self, action: #selector(editingDidEndUserInput), for: .editingDidEnd)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let myPrescriptionsButton: ButtonHomeView = {
        let button = ButtonHomeView(
            icon: UIImage(named: "Paper"),
            title: "Meus medicamentos",
            description: "Acompanhe medicamentos e gerencie lembretes")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let newPrescriptionButton: ButtonHomeView = {
        let button = ButtonHomeView(
            icon: UIImage(named: "Pills"),
            title: "Novo medicamento",
            description: "Cadastre lembretes de medicamentos"
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let feedbackButton: UIButton = {
        let button = UIButton()
        button.setTitle(String(localized: "home.feedback.button"), for: .normal)
        button.setTitleColor(Colors.gray800, for: .normal)
        button.backgroundColor = Colors.gray100
        button.titleLabel?.font = Typography.subHeading
        button.layer.cornerRadius = Metrics.small
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(profileBackground)
        
        profileBackground.addSubview(profileImage)
        profileBackground.addSubview(welcomeLabel)
        profileBackground.addSubview(userTextField)
        
        self.addSubview(contentBackground)
        
        contentBackground.addSubview(myPrescriptionsButton)
        contentBackground.addSubview(newPrescriptionButton)
        contentBackground.addSubview(feedbackButton)
        
        setupConstraints()
        setupImageGesture()
        
        userTextField.delegate = self
        myPrescriptionsButton.delegate = self
        newPrescriptionButton.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileBackground.topAnchor.constraint(equalTo: topAnchor),
            profileBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileBackground.heightAnchor.constraint(equalToConstant: Metrics.backgroundProfileSize),
            
            profileImage.topAnchor.constraint(equalTo: profileBackground.topAnchor, constant: Metrics.profileImageTopDistance),
            profileImage.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: Metrics.medium),
            profileImage.heightAnchor.constraint(equalToConstant: Metrics.profileImageSize),
            profileImage.widthAnchor.constraint(equalToConstant: Metrics.profileImageSize ),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Metrics.tiny),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            
            userTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Metrics.small),
            userTextField.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
             
            contentBackground.topAnchor.constraint(equalTo: profileBackground.bottomAnchor, constant: -Metrics.medium),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            myPrescriptionsButton.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: Metrics.huge),
            myPrescriptionsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            myPrescriptionsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            myPrescriptionsButton.heightAnchor.constraint(equalToConstant: 112),
            
            newPrescriptionButton.topAnchor.constraint(equalTo: myPrescriptionsButton.bottomAnchor, constant: Metrics.small),
            newPrescriptionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            newPrescriptionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            newPrescriptionButton.heightAnchor.constraint(equalToConstant: 112),
            
            
            feedbackButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
            feedbackButton.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor, constant: -Metrics.huge),
            feedbackButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
            feedbackButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium)
        ])
    }
    
    private func setupImageGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func profileImageTapped() {
        delegate?.userProfileImageTapped()
    }
    
    @objc
    private func editingDidEndUserInput() {
        let username = userTextField.text ?? ""
        UserDefaultsManager.saveUsername(name: username)
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension HomeView: ButtonHomeViewDelegate {
    func viewTapped(button: ButtonHomeView) {
        if (button == myPrescriptionsButton) {
            delegate?.navigateToMyMedicines()
        } else if (button == newPrescriptionButton) {
            delegate?.navigateToNewMedicine()
        }
    }
}
