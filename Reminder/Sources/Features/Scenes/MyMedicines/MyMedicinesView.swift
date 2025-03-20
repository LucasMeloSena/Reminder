//
//  MyMedicinesView.swift
//  Reminder
//
//  Created by Lucas Sena on 18/03/25.
//

import Foundation
import UIKit

class MyMedicinesView: UIView {
    weak public var delegate: MyMedicinesDelegate?
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = Colors.gray100
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.addTarget(self, action: #selector(didTappedBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.primaryBlueBase
        button.tintColor = .white
        button.layer.cornerRadius = Metrics.medium
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(didTappedAddMedicineButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.primaryBlueBase
        label.font = Typography.heading
        label.text = "Meus medicamentos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.gray200
        label.font = Typography.body
        label.numberOfLines = 0
        label.text = "Acompanhe seus medicamentos cadastrados e gerencie lembretes."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor =  Colors.gray800
        view.layer.cornerRadius = Metrics.medium
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerView)
        addSubview(contentView)
        
        headerView.addSubview(backButton)
        headerView.addSubview(addButton)
        headerView.addSubview(titleLabel)
        headerView.addSubview(descriptionLabel)
        
        contentView.addSubview(tableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Metrics.backgroundProfileSize),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.medier),
            backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Metrics.medium),
            
            addButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -Metrics.medium),
            addButton.heightAnchor.constraint(equalToConstant: Metrics.huge),
            addButton.widthAnchor.constraint(equalToConstant: Metrics.huge),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Metrics.medium),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -Metrics.medium),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.tiny),
            descriptionLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Metrics.medium),
            descriptionLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -Metrics.medium),
            
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -Metrics.medium),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.medium),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medium),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.medium),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.medium)
        ])
    }
    
    @objc
    private func didTappedBackButton() {
        delegate?.didTappedBackButton()
    }
    
    @objc
    private func didTappedAddMedicineButton() {
        delegate?.didTappedAddMedicineButton()
    }
}
