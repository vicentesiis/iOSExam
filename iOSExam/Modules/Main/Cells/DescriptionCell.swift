//
//  DescriptionCell.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit

final class DescriptionCell: UITableViewCell {
  static let identifier = "DescriptionCell"
  
  // MARK: - UI
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.text = "Description"
    label.font = .systemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    accessoryType = .disclosureIndicator
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup
  private func setupView() {
    contentView.addSubview(descriptionLabel)
    descriptionLabel.pinEdges(to: contentView, insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
  }
}
