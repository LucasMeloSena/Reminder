//
//  HomeViewController.swift
//  Reminder
//
//  Created by Lucas Sena on 14/03/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()
    var contentView: HomeView
    weak var flowDelegate: HomeFlowDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    init(contentView: HomeView, flowDelegate: HomeFlowDelegate?) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindView() {
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setup()
    }
    
    private func setup() {
        buildHierarchy()
        contentView.delegate = self
        checkExistingData()
    }
    
    private func buildHierarchy() {
        setupContentView(contentView: contentView)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        let logoutButton = UIBarButtonItem(image: UIImage(named: "log-out"), style: .plain, target: self, action: #selector(logoutAction))
        logoutButton.tintColor = Colors.primaryRedBase
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc
    private func logoutAction() {
        UserDefaultsManager.deleteUser()
        UserDefaultsManager.deleteUserImage()
        UserDefaultsManager.deleteUsername()
        flowDelegate?.navigateToLogin()
    }
    
    private func checkExistingData() {
        if let username = UserDefaultsManager.loadUsername() {
            contentView.userTextField.text = username
        }
        
        if let userImage = UserDefaultsManager.loadUserImage() {
            contentView.profileImage.image = userImage
        }
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func selectProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            contentView.profileImage.image = selectedImage
            UserDefaultsManager.saveUserImage(image: selectedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            contentView.profileImage.image = originalImage
            UserDefaultsManager.saveUserImage(image: originalImage)
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

extension HomeViewController: HomeViewDelegate {
    func navigateToMyMedicines() {
        flowDelegate?.navigateToMyMedicines()
    }
    
    func navigateToNewMedicine() {
        flowDelegate?.navigateToNewMedicine()
    }
    
    func userProfileImageTapped() {
        selectProfileImage()
    }
}
