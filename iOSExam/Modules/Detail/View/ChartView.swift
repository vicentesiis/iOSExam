//
//  ChartView.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import UIKit
import DGCharts

class ChartView: UIView {
  
  // MARK: - UI
  private let pieChartView = PieChartView()
  
  private let legendStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 12
    return stack
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  // MARK: - Setup
  private func setupView() {
    addSubview(pieChartView)
    addSubview(legendStackView)
    
    pieChartView.translatesAutoresizingMaskIntoConstraints = false
    legendStackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      pieChartView.topAnchor.constraint(equalTo: topAnchor),
      pieChartView.leadingAnchor.constraint(equalTo: leadingAnchor),
      pieChartView.trailingAnchor.constraint(equalTo: trailingAnchor),
      pieChartView.heightAnchor.constraint(equalToConstant: 250),
      
      legendStackView.topAnchor.constraint(equalTo: pieChartView.bottomAnchor, constant: 8),
      legendStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
      legendStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 24),
      legendStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  // MARK: - Configuration
  func configure(with pregunta: Pregunta) {
    pieChartView.holeRadiusPercent = 0.8
    pieChartView.drawEntryLabelsEnabled = false
    pieChartView.legend.enabled = false
    pieChartView.rotationEnabled = false
    pieChartView.holeColor = .clear
    
    let total = pregunta.values.reduce(0) { $0 + $1.value }
    let entries = pregunta.values.map {
      PieChartDataEntry(value: Double($0.value), label: $0.label)
    }
    
    let dataSet = PieChartDataSet(entries: entries, label: "")
    let colors = ChartColorTemplates.material() + ChartColorTemplates.vordiplom()
    dataSet.colors = Array(colors.prefix(entries.count))
    
    let data = PieChartData(dataSet: dataSet)
    data.setValueFormatter(DefaultValueFormatter(formatter: percentFormatter(total: total)))
    data.setValueFont(.systemFont(ofSize: 14))
    data.setValueTextColor(.black)
    
    data.setDrawValues(false)
    
    pieChartView.data = data
    
    // Legends
    legendStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    
    for (index, chunk) in pregunta.values.chunked(into: 2).enumerated() {
      let row = UIStackView()
      row.axis = .horizontal
      row.spacing = 12
      row.distribution = .fillEqually
      
      for (subIndex, value) in chunk.enumerated() {
        let colorView = UIView()
        colorView.backgroundColor = colors[index * 2 + subIndex]
        colorView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        colorView.layer.cornerRadius = 8
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = UIColor.systemGray
        label.text = "\(value.label) \(percentageText(for: value.value, total: total))"
        
        let pair = UIStackView(arrangedSubviews: [colorView, label])
        pair.axis = .horizontal
        pair.spacing = 4
        row.addArrangedSubview(pair)
      }
      
      legendStackView.addArrangedSubview(row)
    }
  }
  
  // MARK; - Helper Methods
  private func percentFormatter(total: Int) -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent
    formatter.maximumFractionDigits = 0
    formatter.multiplier = NSNumber(value: 100.0 / Double(total))
    return formatter
  }
  
  private func percentageText(for value: Int, total: Int) -> String {
    guard total > 0 else { return "0%" }
    let percent = Double(value) / Double(total) * 100
    return String(format: "%.0f%%", percent)
  }
}
