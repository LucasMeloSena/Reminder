//
//  NewMedicineView.swift
//  Reminder
//
//  Created by Lucas Sena on 16/03/25.
//

import Foundation
import UIKit
import Lottie

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
    
    let timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    let timeInput = Input(title: "Horário", placeholder: "12:00")
    
    let recurrencePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let recurrenceOptions = [
        "1/1",
        "2/2",
        "4/4",
        "6/6",
        "8/8",
        "12/12",
        "24/24"
    ]
    
    let recurrenceInput = Input(title: "Recorrência", placeholder: "Selecione")
    let takeMedicineNow = Checkbox(title: "Tomar o remédio agora?")
    
    let addButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Typography.subHeading
        button.setTitle("+ Adicionar", for: .normal)
        button.backgroundColor = button.isEnabled ? Colors.primaryRedBase : Colors.gray500
        button.layer.cornerRadius = 12
        button.setTitleColor(Colors.gray800, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let successAnimationView: LottieAnimationView = { 
        let animationView = LottieAnimationView(name: "Create-Medicine-Animation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.isHidden = true
        return animationView
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
        addSubview(recurrenceInput)
        addSubview(takeMedicineNow)
        addSubview(addButton)
        addSubview(successAnimationView)
        
        setupConstraints()
        setupTimePicker()
        setupRecurrencePicker()
        setupObservers()
        validateInputs()
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
            
            recurrenceInput.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: Metrics.medium),
            recurrenceInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.high),
            recurrenceInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.high),
            
            takeMedicineNow.topAnchor.constraint(equalTo: recurrenceInput.bottomAnchor, constant: Metrics.medium),
            takeMedicineNow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.high),
            takeMedicineNow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.high),
            
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.medium),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.high),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.high),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            
            successAnimationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            successAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            successAnimationView.heightAnchor.constraint(equalToConstant: 120),
            successAnimationView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupTimePicker() {
        let tollbar = UIToolbar()
        tollbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectedTime))
        tollbar.setItems([doneButton], animated: true)
        
        timeInput.input.inputView = timePicker
        timeInput.input.inputAccessoryView = tollbar
    }
    
    @objc
    private func didSelectedTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeInput.input.text = formatter.string(from: timePicker.date)
        timeInput.input.resignFirstResponder()
        validateInputs()
    }
    
    private func setupRecurrencePicker() {
        let tollbar = UIToolbar()
        tollbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didRecurrenceSelected))
        tollbar.setItems([doneButton], animated: true)
        
        recurrenceInput.input.inputView = recurrencePicker
        recurrenceInput.input.inputAccessoryView = tollbar
        recurrencePicker.delegate = self
        recurrencePicker.dataSource = self
    }
    
    @objc
    private func didRecurrenceSelected() {
        let selectedRow = recurrencePicker.selectedRow(inComponent: 0)
        recurrenceInput.input.text = recurrenceOptions[selectedRow]
        recurrenceInput.input.resignFirstResponder()
        validateInputs()
    }
    
    private func validateInputs() {
        let isMedicineFilled = !(medicineInput.input.text ?? "").isEmpty
        let isTimeFilled = !(timeInput.input.text ?? "").isEmpty
        let isRecurrenceFilled = !(recurrenceInput.input.text ?? "").isEmpty
        
        addButton.isEnabled = isMedicineFilled && isTimeFilled && isRecurrenceFilled
        addButton.backgroundColor = addButton.isEnabled ? Colors.primaryRedBase : Colors.gray500
    }
    
    private func setupObservers() {
        medicineInput.input.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        timeInput.input.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        recurrenceInput.input.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
    }
    
    @objc
    private func inputDidChange() {
        validateInputs()
    }
    
    func playSuccessAnimation() {
        successAnimationView.isHidden = false
        successAnimationView.play { [weak self] finished in
            if (finished) {
                self?.successAnimationView.isHidden = true
            }
        }
    }
    
    func clearFields() {
        medicineInput.input.text = ""
        timeInput.input.text = ""
        recurrenceInput.input.text = ""
        addButton.isEnabled = false
    }
}

extension NewMedicineView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recurrenceOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recurrenceOptions[row]
    }
}
