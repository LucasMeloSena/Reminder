//
//  LoginBottomSheetViewController.swift
//  Reminder
//
//  Created by Lucas Sena on 13/03/25.
//

import Foundation
import UIKit

class LoginBottomSheetViewController: UIViewController {
    let viewModel = LoginBottomSheetViewModel()
    var contentView: LoginBottomSheetView
    
    var handleAreaHeight: CGFloat = 50.0
    weak var flowDelegate: LoginBottomSheetFlowDelegate?
    
    init(contentView: LoginBottomSheetView, flowDelegate: LoginBottomSheetFlowDelegate) {
        self.flowDelegate = flowDelegate
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
        setupUI()
        setupGesture()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupGesture() {
        
    }
    
    private func handlePanGesture() {
         
    }
    
    private func presentSaveLoginAlert(email: String) {
        let alertController = UIAlertController(title: "Aviso", message: "Continuar conectado?", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Sim", style: .default) { _ in
            let user = User(email: email, isUserSaved: true)
            UserDefaultsManager.saveUser(user: user )
            self.flowDelegate?.navigateToHome()
        }
        let cancelAction = UIAlertAction(title: "Não", style: .cancel) { _ in
            self.flowDelegate?.navigateToHome()
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.didFinishedAuth = { [weak self] email in
            self?.presentSaveLoginAlert(email: email)
        }
        
        viewModel.error = { [weak self] errorMessage in 
            self?.presentErrorAlert(message: errorMessage)
        }
    }
    
    private func presentErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tentar Novamente", style: .default)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func animateShow(completion: (() -> Void)? = nil) {
        self.view.layoutIfNeeded()
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = .identity
            self.view.layoutIfNeeded()
        }) { _ in
            completion?()
        }
    }
}

extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendLoginData(email: String, password: String) {
        viewModel.doAuth(email: email, password: password)
    }
}
