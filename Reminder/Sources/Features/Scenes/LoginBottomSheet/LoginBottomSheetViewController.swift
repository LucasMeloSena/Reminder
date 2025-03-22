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
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
            contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
        ])
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
    
    @objc
    private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.view.frame.origin.y = -keyboardHeight / 1.7
        }
    }
    
    @objc
    private func keyboardWillHide() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.view.frame.origin.y = 0
        }
    }
}

extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendLoginData(email: String, password: String) {
        viewModel.doAuth(email: email, password: password)
    }
}
