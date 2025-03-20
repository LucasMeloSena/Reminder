//
//  MedicineCell.swift
//  Reminder
//
//  Created by Lucas Sena on 18/03/25.
//

import Foundation
import UIKit

class MedicineCell: UITableViewCell {
    static let identifier = "medicine-cell"
    
    var onDelete: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.subHeading
        label.textColor = Colors.gray200
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trashButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trash-2")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = Colors.primaryRedBase
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didDeleteMediceTapped), for: .touchUpInside)
        return button
    }()
    
    private let timeView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray500
        view.layer.cornerRadius = Metrics.medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.tag
        label.textColor = Colors.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let recurrenceView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray500
        view.layer.cornerRadius = Metrics.medium
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let recurrenceLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.tag
        label.textColor = Colors.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let watchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clock")
        imageView.tintColor = Colors.gray300
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let recurrenceIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "repeat")
        imageView.tintColor = Colors.gray300
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = Metrics.medium
        contentView.backgroundColor = Colors.gray700
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(trashButton)
        contentView.addSubview(timeView)
        timeView.addSubview(watchIcon)
        timeView.addSubview(timeLabel)
        contentView.addSubview(recurrenceView)
        recurrenceView.addSubview(recurrenceIcon)
        recurrenceView.addSubview(recurrenceLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.medier),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medier),
            
            trashButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            trashButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.medium),
            trashButton.widthAnchor.constraint(equalToConstant: 16),
            trashButton.heightAnchor.constraint(equalToConstant: 16),
            
            timeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.small),
            timeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medier),
            timeView.heightAnchor.constraint(equalToConstant: 28),
            
            watchIcon.leadingAnchor.constraint(equalTo: timeView.leadingAnchor, constant: Metrics.small),
            watchIcon.centerYAnchor.constraint(equalTo: timeView.centerYAnchor),
            watchIcon.heightAnchor.constraint(equalToConstant: 16),
            watchIcon.widthAnchor.constraint(equalToConstant: 16),
            
            timeLabel.leadingAnchor.constraint(equalTo: watchIcon.trailingAnchor, constant: Metrics.tiny),
            timeLabel.centerYAnchor.constraint(equalTo: timeView.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: -Metrics.small),
            
            recurrenceView.centerYAnchor.constraint(equalTo: timeView.centerYAnchor),
            recurrenceView.leadingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: Metrics.tiny),
            recurrenceView.heightAnchor.constraint(equalToConstant: 28),
            
            recurrenceIcon.leadingAnchor.constraint(equalTo: recurrenceView.leadingAnchor, constant: Metrics.small),
            recurrenceIcon.centerYAnchor.constraint(equalTo: recurrenceView.centerYAnchor),
            recurrenceIcon.heightAnchor.constraint(equalToConstant: 16),
            recurrenceIcon.widthAnchor.constraint(equalToConstant: 16),
            
            recurrenceLabel.leadingAnchor.constraint(equalTo: recurrenceIcon.trailingAnchor, constant: Metrics.tiny),
            recurrenceLabel.centerYAnchor.constraint(equalTo: recurrenceView.centerYAnchor),
            recurrenceLabel.trailingAnchor.constraint(equalTo: recurrenceView.trailingAnchor, constant: -Metrics.small),
        ])
    }
    
    func configure(title: String, time: String, recurrence: String) {
        titleLabel.text = title
        timeLabel.text = time
        recurrenceLabel.text = recurrence
    }
    
    @objc
    private func didDeleteMediceTapped() {
        onDelete?()
    }
}
