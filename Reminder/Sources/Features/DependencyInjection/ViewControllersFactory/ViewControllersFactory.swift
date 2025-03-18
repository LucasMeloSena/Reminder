//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by Lucas Sena on 14/03/25.
//

import Foundation
import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeNewMedicineController(flowDelegate: NewMedicineFlowDelegate) -> NewMedicineViewController {
        let contentView = NewMedicineView()
        let viewController = NewMedicineViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let contentView = SplashView()
        let viewController = SplashViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        let contentView = LoginBottomSheetView()
        let viewController = LoginBottomSheetViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
        let contentView = HomeView()
        let viewController = HomeViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }
}
