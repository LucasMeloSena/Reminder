//
//  ReminderFlowController.swift
//  Reminder
//
//  Created by Lucas Sena on 14/03/25.
//

import Foundation
import UIKit

// CORDINATOR
class ReminderFlowController {
    // MARK: - Properties
    private var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactoryProtocol
    
    // MARK: - init
    public init() {
        self.viewControllerFactory = ViewControllersFactory()
    }
    
    // MARK: - startView
    func start() -> UINavigationController? {
        let startViewController = viewControllerFactory.makeSplashViewController(flowDelegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

// MARK: - Splash
extension ReminderFlowController: SplashFlowDelegate { 
    func navigateToLoginBottomSheet() {
        let loginBottomSheet = viewControllerFactory.makeLoginBottomSheetViewController(flowDelegate: self)
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(loginBottomSheet, animated: false) {
            loginBottomSheet.animateShow()
        }
    }
}

// MARK: - Login
extension ReminderFlowController: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        self.navigationController?.dismiss(animated: false)
        let homeViewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
}


// MARK: - Home
extension ReminderFlowController: HomeFlowDelegate {
    func navigateToMyMedicines() {
        let myMedicinesController = viewControllerFactory.makeMyMedicinesController(flowDelegate: self)
        self.navigationController?.pushViewController(myMedicinesController, animated: true)
    }
    
    func navigateToLogin() {
        self.navigationController?.popViewController(animated: true)
        self.navigateToLoginBottomSheet()
    }
}

// MARK: - NewMedicine
extension ReminderFlowController: NewMedicineFlowDelegate {
    func navigateToNewMedicine() {
        let newMedicineController = viewControllerFactory.makeNewMedicineController(flowDelegate: self)
        self.navigationController?.pushViewController(newMedicineController, animated: true)
    }
    
    func navigateToHomeFromNewMedicine() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - MyMedicines
extension ReminderFlowController: MyMedicinesFlowDelegate {
    
}
