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
    let tf = UITextField()
    tf.placeholder = "Ingresa tu nombre"
    tf.borderStyle = .roundedRect
    tf.autocapitalizationType = .words
    tf.translatesAutoresizingMaskIntoConstraints = false
    return tf
  }()
  
  var textDidChange: ((String) -> Void)?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    nameTextField.delegate = self
    nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    setupView()
  }
  
  // MARK: - Setup
  private func setupView() {
    selectionStyle = .none
    backgroundColor = .clear
    
    contentView.addSubview(nameTextField)
    
    nameTextField.pinEdges(to: contentView, insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc private func textFieldDidChange(_ textField: UITextField) {
    textDidChange?(textField.text ?? "")
  }
}

// MARK: - UITextFieldDelegate
extension NameCell: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let allowedCharacters = CharacterSet.letters.union(.whitespaces)
    let characterSet = CharacterSet(charactersIn: string)
    return allowedCharacters.isSuperset(of: characterSet)
  }
}
