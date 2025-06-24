//
//  MainInteractor.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import Foundation

protocol MainInteractorProtocol: AnyObject {}

final class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol?
}
