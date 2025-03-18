//
//  NewMedicineViewController.swift
//  Reminder
//
//  Created by Lucas Sena on 16/03/25.
//

import Foundation
import UIKit

class NewMedicineViewController: UIViewController {
    var contentView: NewMedicineView
    weak var flowDelegate: NewMedicineFlowDelegate?
    
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
    }
    
    @objc
    func backScreen() {
        self.flowDelegate?.navigateToHomeFromNewMedicine()
    }
}
