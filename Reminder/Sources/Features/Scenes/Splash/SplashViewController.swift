//
//  SplashViewController.swift
//  Reminder
//
//  Created by Lucas Sena on 12/03/25.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    var contentView: SplashView
    weak var flowDelegate: SplashFlowDelegate?
    
    init(contentView: SplashView, flowDelegate: SplashFlowDelegate) {
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
        splashViewBreathingAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func decideNavigationFlow() {
        if let user = UserDefaultsManager.loadUser(), user.isUserSaved {
            flowDelegate?.navigateToHome()
        } else {
            flowDelegate?.navigateToLoginBottomSheet()
            animateLogoUp()
        }
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupContentView(contentView: contentView)
    }
}

// MARK: - Animations
extension SplashViewController {
    private func splashViewBreathingAnimation() {
        UIView.animate(withDuration: 0.8, delay: 0.0, animations: {
            self.contentView.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            self.decideNavigationFlow()
        })
    }
    
    private func animateLogoUp() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
            self.contentView.logoImageView.transform = self.contentView.logoImageView.transform.translatedBy(x: 0, y: -120)
        })
    }
}
