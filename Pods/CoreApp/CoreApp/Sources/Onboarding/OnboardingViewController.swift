//
//  OnboardingView.swift
//  CoreApp
//
//  Created by Lucas Sena on 23/03/25.
//

import Foundation
import UIKit

public class OnboardingViewController: UIViewController {
    private var content: (title: String, description: [String])?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Typography.heading
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Typography.subHeading
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.backgroundColor = Colors.primaryRedBase
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Typography.label
        button.addTarget(self, action: #selector(didTappedNextStep), for: .touchUpInside)
        button.layer.cornerRadius = Metrics.small
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public init(content: (title: String, description: [String])) {
        self.titleLabel.text = content.title
        self.descriptionLabel.text = content.description.joined(separator: "\n\n")
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(nextButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metrics.huge),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.medium),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.medium),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.medium),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.medium),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.medium),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.huge),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.huge),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func dismiss() {
        dismiss(animated: true)
    }
    
    @objc
    private func didTappedNextStep() {
        dismiss()
    }
}
