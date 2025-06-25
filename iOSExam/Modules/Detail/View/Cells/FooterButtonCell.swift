//
//  FooterButtonCell.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import UIKit

class FooterButtonCell: UITableViewCell {
  static let identifier = "FooterButtonCell"
  
  // MARK: - UI
  private let button: UIButton = {
    let btn = UIButton(type: .system)
    btn.setTitle("Enviar Datos", for: .normal)
    btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
    btn.setTitleColor(.systemBlue, for: .normal)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.layer.cornerRadius = 8
    btn.layer.borderWidth = 1
    btn.layer.borderColor = UIColor.systemBlue.cgColor
    return btn
  }()
  
  var buttonAction: (() -> Void)?
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  private func setupView() {
    backgroundColor = .clear
    contentView.addSubview(button)
    
    button.pinEdges(to: contentView, insets: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
  }
  
  @objc private func buttonTapped() {
    buttonAction?()
  }
  
}
