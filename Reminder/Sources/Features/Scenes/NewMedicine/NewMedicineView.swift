//
//  NewMedicineView.swift
//  Reminder
//
//  Created by Lucas Sena on 16/03/25.
//

import Foundation
import UIKit

class NewMedicineView: UIView {    
    let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = Colors.gray100
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Novo Medicamento"
        label.font = Typography.heading
        label.textColor = Colors.primaryRedBase
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Adicione a sua prescrição médica para receber lembretes de quando tomar seu medicamento."
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let medicineInput = Input(title: "Remédio", placeholder: "Nome do medicamento")
    let timeInput = Input(title: "Horário", placeholder: "12:00")
    let recurrencyInput = Input(title: "Recorrência", placeholder: "Selecione")
    let takeMedicineNow = Checkbox(title: "Tomar o remédio agora?")
    
    let addButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Typography.subHeading
        button.setTitle("+ Adicionar", for: .normal)
        button.backgroundColor = Colors.primaryRedBase
        button.layer.cornerRadius = 12
        button.setTitleColor(Colors.gray800, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(medicineInput)
        addSubview(timeInput)
        addSubview(recurrencyInput)
        addSubview(takeMedicineNow)
        addSubview(addButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.huge),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            backButton.widthAnchor.constraint(equalToConstant: Metrics.medium),
            backButton.heightAnchor.constraint(equalToConstant: Metrics.medium),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.high),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.tiny),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.high),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.high),
            
            medicineInput.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.medium),
            medicineInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.high),
            medicineInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.high),
            
            timeInput.topAnchor.constraint(equalTo: medicineInput.bottomAnchor, constant: Metrics.medium),
            timeInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.high),
            timeInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.high),
            
            recurrencyInput.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: Metrics.medium),
            recurrencyInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.high),
            recurrencyInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.high),
            
            takeMedicineNow.topAnchor.constraint(equalTo: recurrencyInput.bottomAnchor, constant: Metrics.medium),
            takeMedicineNow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.high),
            takeMedicineNow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.high),
            
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.medium),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.high),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.high),
            addButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
