//
//  NameCell.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit

final class NameCell: UITableViewCell {
    static let identifier = "NameCell"

    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ingresa tu nombre"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .words
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(nameTextField)
        setupConstraints()
        
        nameTextField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension NameCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
