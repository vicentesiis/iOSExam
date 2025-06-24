//
//  MainPresenter.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol?
    var router: MainRouter?

    func viewDidLoad() {
        view?.setupUI()
    }
}
