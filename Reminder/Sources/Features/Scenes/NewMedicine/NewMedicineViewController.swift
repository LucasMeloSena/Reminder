//
//  NewMedicineViewController.swift
//  Reminder
//
//  Created by Lucas Sena on 16/03/25.
//

import Foundation
import UIKit
import CoreApp

class NewMedicineViewController: UIViewController {
    var contentView: NewMedicineView
    weak var flowDelegate: NewMedicineFlowDelegate?
    private let viewModel = NewMedicineViewModel()
    
    init(contentView: NewMedicineView, flowDelegate: NewMedicineFlowDelegate?) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        let onboarding = OnboardingViewController(content: (title: "Welcome to Reminder!", description: [
            "1. We are here to make your medicines management easier.",
            "2. We are the complete mobile app to help you to remember when take your medicines.",
            "3. Have a new and healthier life with our app as never before now.",
        ]))
        navigationController?.present(onboarding, animated: true)
    }
    
    func setupView() {
        view.backgroundColor = Colors.gray800
        
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        setupContentView(contentView: contentView)
    }
    
    func setupActions() {
        contentView.backButton.addTarget(self, action: #selector(backScreen), for: .touchUpInside)
        contentView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backScreen() {
        self.flowDelegate?.navigateToHomeFromNewMedicine()
    }
    
    @objc
    private func addButtonTapped() {
        let medicineName = contentView.medicineInput.getText()
        let time = contentView.timeInput.getText()
        let recurrence = contentView.recurrenceInput.getText()
        let takeNow = false
        
        let medicine = Medicine(id: nil, name: medicineName, time: time, recurrence: recurrence, takeNow: takeNow)
        viewModel.addMedicine(medicine: medicine)
        contentView.playSuccessAnimation()
        contentView.clearFields()
    }
}
