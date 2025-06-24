//
//  MainViewController.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit
import AVFoundation

protocol MainViewProtocol: AnyObject {
  func reloadTable()
  func presentSelfieOptions()
  func presentSelfiePreview(image: UIImage)
  func presentImagePicker(_ picker: UIImagePickerController)
}

final class MainViewController: UIViewController {
  
  // MARK: - Properties
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
    setupUI()
    setupTapToDismissKeyboard()
    presenter?.viewDidLoad()
  }
  
  // MARK: - Setup
  private func setupUI() {
    view.addSubview(tableView)
    setupConstraints()
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(NameCell.self, forCellReuseIdentifier: NameCell.identifier)
    tableView.register(SelfieCell.self, forCellReuseIdentifier: SelfieCell.identifier)
    tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.identifier)
  }
  
  private func setupConstraints() {
    tableView.pinEdgesToSuperview()
  }
  
  private func setupTapToDismissKeyboard() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
  func reloadTable() {
    tableView.reloadData()
  }
  
  func presentSelfieOptions() {
    let alert = UIAlertController(title: "Selfie", message: "Elige una opción", preferredStyle: .actionSheet)
    
    if selfieImage != nil {
      alert.addAction(UIAlertAction(title: "Ver selfie", style: .default) { [weak self] _ in
        guard let image = self?.selfieImage else { return }
        self?.presentSelfiePreview(image: image)
      })
    }
    
    alert.addAction(UIAlertAction(title: selfieImage == nil ? "Tomar selfie" : "Retomar selfie", style: .default) { [weak self] _ in
      self?.presentCameraOrLibrary()
    })
    
    alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
    
    present(alert, animated: true)
  }
  
  func presentSelfiePreview(image: UIImage) {
    let previewVC = UIViewController()
    previewVC.view.backgroundColor = .black
    
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    imageView.frame = previewVC.view.bounds
    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    previewVC.view.addSubview(imageView)
    
    present(previewVC, animated: true)
  }
  
  func presentImagePicker(_ picker: UIImagePickerController) {
    present(picker, animated: true)
  }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int { 1 }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      return tableView.dequeueReusableCell(withIdentifier: NameCell.identifier, for: indexPath)
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: SelfieCell.identifier, for: indexPath) as! SelfieCell
      cell.hasSelfie = (selfieImage != nil)
      return cell
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as! DescriptionCell
      cell.descriptionLabel.text = presenter?.descriptionText
      return cell
    default:
      fatalError("Unexpected row")
    }
  }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 1 {
      presentSelfieOptions()
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.originalImage] as? UIImage {
      selfieImage = image
    }
    DispatchQueue.main.async {
      self.reloadTable()
      picker.dismiss(animated: true)
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    DispatchQueue.main.async {
      picker.dismiss(animated: true)
    }
  }
}

// MARK: - Private Camera Helpers
private extension MainViewController {
  func presentCameraOrLibrary() {
#if targetEnvironment(simulator)
    presentPhotoLibrary()
#else
    presentCamera()
#endif
  }
  
  func presentCamera() {
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
            print("Permission denied")
          }
        }
      }
    case .denied, .restricted:
      print("Permission denied")
    @unknown default:
      print("Unknown auth status")
    }
  }
  
  func showCameraPicker() {
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.cameraDevice = .front
    picker.delegate = self
    presentImagePicker(picker)
  }
  
  func presentPhotoLibrary() {
    let picker = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.delegate = self
    presentImagePicker(picker)
  }
}
