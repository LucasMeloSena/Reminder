//
//  ViewControllersFactoryProtocol.swift
//  Reminder
//
//  Created by Lucas Sena on 14/03/25.
//

import Foundation

protocol ViewControllersFactoryProtocol: AnyObject {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController
    func makeNewMedicineController(flowDelegate: NewMedicineFlowDelegate) -> NewMedicineViewController
    func makeMyMedicinesController(flowDelegate: MyMedicinesFlowDelegate) -> MyMedicinesViewController
}
