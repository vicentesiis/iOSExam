//
//  MainViewController.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func setupUI()
}

final class MainViewController: UIViewController, MainViewProtocol {
    var presenter: MainPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Main"
        presenter?.viewDidLoad()
    }

    func setupUI() {}
  
}
