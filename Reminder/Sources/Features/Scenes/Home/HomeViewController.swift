//
//  HomeViewController.swift
//  Reminder
//
//  Created by Lucas Sena on 14/03/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    var contentView: HomeView
    var flowDelegate: HomeFlowDelegate?
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(contentView: HomeView, flowDelegate: HomeFlowDelegate?) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
