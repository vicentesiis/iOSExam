//
//  MainViewController.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit
import AVFoundation

protocol MainViewProtocol: AnyObject {
    func setupUI()
}

final class MainViewController: UIViewController, MainViewProtocol {
    var presenter: MainPresenterProtocol?
    private var selfieImage: UIImage?
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Examen iOS"
        presenter?.viewDidLoad()
        setupUI()
        setupTapToDismissKeyboard()
    }
    
    // MARK: - MainViewProtocol
    func setupUI() {
        view.addSubview(tableView)
        setupConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NameCell.self, forCellReuseIdentifier: NameCell.identifier)
        tableView.register(SelfieCell.self, forCellReuseIdentifier: SelfieCell.identifier)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.identifier)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // TODO: - Make it reusable.
    private func setupTapToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // So tableView didSelectRow still works
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.identifier, for: indexPath) as! NameCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelfieCell.identifier, for: indexPath) as! SelfieCell
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as! DescriptionCell
            return cell
        default: fatalError("Ups")
        }
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
}


// MARK: - SelfieCellDelegate
extension MainViewController: SelfieCellDelegate {
    func selfieCellDidRequestCamera(_ cell: SelfieCell) {
        let alert = UIAlertController(title: "Selfie", message: "Elige una opción", preferredStyle: .actionSheet)
        
        if selfieImage != nil {
            alert.addAction(UIAlertAction(title: "Ver selfie", style: .default, handler: { [weak self] _ in
                self?.showSelfiePreview()
            }))
        }
        
        alert.addAction(UIAlertAction(title: selfieImage == nil ? "Tomar selfie" : "Retomar selfie", style: .default, handler: { [weak self] _ in
            self?.presentCameraOrLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func presentCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .authorized:
            showCameraPicker()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    if granted {
                        self?.showCameraPicker()
                    } else {
                        print("Sin permiso :(")
                    }
                }
            }
        case .denied, .restricted:
            print("Sin permiso :(")
        @unknown default:
            print("???")
        }
    }
    
    private func showCameraPicker() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.cameraDevice = .front
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func presentPhotoLibrary() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func presentCameraOrLibrary() {
#if targetEnvironment(simulator)
        presentPhotoLibrary()
#else
        presentCamera()
#endif
    }
    
    private func showSelfiePreview() {
        guard let image = selfieImage else { return }
        let previewVC = UIViewController()
        previewVC.view.backgroundColor = .black
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = previewVC.view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        previewVC.view.addSubview(imageView)
        
        present(previewVC, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selfieImage = image
            tableView.reloadData()
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
