//
//  CustomTextField.swift
//  almofire
//
//  Created by heawon on 2021/03/31.
//

import UIKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        leftViewMode = .always
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
        backgroundColor = .secondarySystemBackground
        autocorrectionType = .no
        autocapitalizationType = .none
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
