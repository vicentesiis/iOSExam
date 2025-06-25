//
//  DetailViewController.swift
//  iOSExam
//
//  Created by Vicente Cantu on 24/06/25.
//

import UIKit
import DGCharts

protocol DetailViewProtocol: AnyObject {
  func displayQuestions(_ preguntas: [Pregunta])
  func displayError(_ message: String)
  func displaySuccess(_ message: String)
}

class DetailViewController: UIViewController {
  
  // MARK: - Properties
  var presenter: DetailPresenterProtocol!
  private var preguntas: [Pregunta] = []
  
  // MARK: - UI
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    return tableView
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Detail"
    setupUI()
    presenter.viewDidLoad()
  }
  
  // MARK: - Setup
  private func setupUI() {
    view.addSubview(tableView)
    tableView.pinEdges(to: view, useSafeArea: true)
    
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 400
    tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: ChartTableViewCell.identifier)
    tableView.register(FooterButtonCell.self, forCellReuseIdentifier: FooterButtonCell.identifier)
  }
}

// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
  
  func displayQuestions(_ preguntas: [Pregunta]) {
    self.preguntas = preguntas
    
    runOnMain {
      self.tableView.reloadData()
    }
  }
  
  func displayError(_ message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    runOnMain {
      self.present(alert, animated: true)
    }
  }

  func displaySuccess(_ message: String) {
    let alert = UIAlertController(title: "Éxito", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    runOnMain {
      self.present(alert, animated: true)
    }
  }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    preguntas.count + 1 // Questions + Footer
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == preguntas.count {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: FooterButtonCell.identifier, for: indexPath) as? FooterButtonCell else {
        return UITableViewCell()
      }
      cell.buttonAction = { [weak self] in
        self?.presenter.didTapFooterButton()
      }
      return cell
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.identifier, for: indexPath) as? ChartTableViewCell else {
        return UITableViewCell()
      }
      let pregunta = preguntas[indexPath.row]
      cell.configure(with: pregunta)
      return cell
    }
  }
  
}
