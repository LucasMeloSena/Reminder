//
//  ButtonHomeView.swift
//  Reminder
//
//  Created by Lucas Sena on 15/03/25.
//

import Foundation
import UIKit

class ButtonHomeView: UIView {
    public weak var delegate: ButtonHomeViewDelegate?
    
    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        view.layer.cornerRadius = Metrics.small
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.subHeading
        label.textColor = Colors.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevron-right")
        imageView.tintColor = Colors.gray300
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(icon: UIImage?, title: String, description: String) {
        super.init(frame: .zero)
        
        iconImageView.image = icon
        titleLabel.text = title
        descriptionLabel.text = description
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func viewTapped() {
        delegate?.viewTapped(button: self)
    }
    
    private func setup() {
        backgroundColor = Colors.gray700
        layer.cornerRadius = Metrics.small
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(iconView)
        iconView.addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
        
        setupViewGesture()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.small),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.tiny),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.small),
            iconView.widthAnchor.constraint(equalToConstant: 100),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Metrics.huge),
            iconImageView.heightAnchor.constraint(equalToConstant: Metrics.huge),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: iconView.topAnchor, constant: Metrics.tiny),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.tiny),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            arrowImageView.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.small),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            arrowImageView.widthAnchor.constraint(equalToConstant: Metrics.medier),
            arrowImageView.heightAnchor.constraint(equalToConstant: Metrics.medier)
        ])
    }
}
