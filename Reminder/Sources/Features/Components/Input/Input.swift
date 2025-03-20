//
//  InputView.swift
//  Reminder
//
//  Created by Lucas Sena on 16/03/25.
//

import Foundation
import UIKit

class Input: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.label
        label.textColor = Colors.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let input: UITextField = {
        let input = UITextField()
        input.font = Typography.input
        input.textColor = Colors.gray100
        input.borderStyle = .roundedRect
        input.backgroundColor = Colors.gray800
        input.layer.borderWidth = 1
        input.layer.borderColor = Colors.gray400.cgColor
        input.layer.cornerRadius = Metrics.small
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        
        setup()
        setupConstraints()
        configurePlaceholder(placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(input)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 85),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            input.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            input.leadingAnchor.constraint(equalTo: leadingAnchor),
            input.trailingAnchor.constraint(equalTo: trailingAnchor),
            input.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func configurePlaceholder(placeholder: String) {
        input.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: Colors.gray200])
    }
    
    func getText() -> String {
        return input.text ?? ""
    }
}
