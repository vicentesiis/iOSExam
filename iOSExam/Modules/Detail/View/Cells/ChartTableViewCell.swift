//
//  ChartTableViewCell.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import UIKit
import DGCharts

class ChartTableViewCell: UITableViewCell {
  static let identifier = "ChartTableViewCell"
  
  // MARK: - UI
  private let questionLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 30)
    label.textAlignment = .left
    label.textColor = UIColor.systemGray
    label.numberOfLines = 0
    return label
  }()
  
  private let chartView = ChartView()
  
  private let mainStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 12
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
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
    selectionStyle = .none
    backgroundColor = .clear
    
    contentView.addSubview(mainStackView)
    
    mainStackView.addArrangedSubview(questionLabel)
    mainStackView.addArrangedSubview(chartView)
    
    mainStackView.pinEdges(to: contentView, insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
  }
  
  func configure(with pregunta: Pregunta) {
    questionLabel.text = pregunta.pregunta
    chartView.configure(with: pregunta)
  }
}
