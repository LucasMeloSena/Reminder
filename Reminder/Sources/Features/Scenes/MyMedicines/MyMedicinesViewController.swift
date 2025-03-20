//
//  MyMedicineViewController.swift
//  Reminder
//
//  Created by Lucas Sena on 16/03/25.
//

import Foundation
import UIKit

class MyMedicinesViewController: UIViewController {
    var contentView: MyMedicinesView
    var flowDelegate: MyMedicinesFlowDelegate?
    let viewModel = MyMedicinesViewModel()
    
    private var medicines: [Medicine] = []
    
    init(contentView: MyMedicinesView, flowDelegate: MyMedicinesFlowDelegate?) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTableView()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setup() {
        view.backgroundColor = Colors.gray800
        view.addSubview(contentView)
        
        setupConstraints()
        contentView.delegate = self
    }
    
    private func setupConstraints() {
        setupContentView(contentView: contentView)
    }
    
    private func setupTableView() {
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(MedicineCell.self, forCellReuseIdentifier: MedicineCell.identifier)
        contentView.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    private func loadData() {
        medicines = viewModel.fetchData()
    }
}

extension MyMedicinesViewController: MyMedicinesDelegate {
    func didTappedBackButton() {
        flowDelegate?.navigateToHomeFromNewMedicine()
    }
    
    func didTappedAddMedicineButton() {
        flowDelegate?.navigateToNewMedicine()
    }
}

extension MyMedicinesViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return medicines.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
}

extension MyMedicinesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MedicineCell.identifier, for: indexPath) as! MedicineCell
        let medicine = medicines[indexPath.section]
        
        cell.configure(title: medicine.name, time: medicine.time, recurrence: medicine.recurrence)
        cell.onDelete = { [weak self] in
            guard let self = self else { return }
            
            if let updatedIndexPath = tableView.indexPath(for: cell),
               updatedIndexPath.section < medicines.count,
               let medicineId = medicine.id {
                self.viewModel.deleteMedicine(byId: medicineId)
                self.medicines.remove(at: updatedIndexPath.row)
                tableView.deleteSections(IndexSet(integer: updatedIndexPath.section), with: .automatic)
            }
        }
        
        return cell
    }
}
