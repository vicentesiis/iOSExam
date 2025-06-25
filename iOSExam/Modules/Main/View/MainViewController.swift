//
//  MainViewController.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit
import AVFoundation

protocol MainViewProtocol: AnyObject {}

final class MainViewController: UIViewController {
  
  // MARK: - Properties
  var presenter: MainPresenterProtocol?
  
  // MARK: - UI
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.backgroundColor = .clear
    return tableView
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Examen iOS"
    setupUI()
  }
  
  // MARK: - Setup
  private func setupUI() {
    view.addSubview(tableView)
    tableView.pinEdges(to: view, useSafeArea: true)
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(NameCell.self, forCellReuseIdentifier: NameCell.identifier)
    tableView.register(SelfieCell.self, forCellReuseIdentifier: SelfieCell.identifier)
    tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.identifier)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
  
  @objc private func sendButtonTapped() {
    presenter?.didTapGoToDetail()
  }
}

// MARK: - MainViewProtocol (Future Interactions)
extension MainViewController: MainViewProtocol {}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int { 1 }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: NameCell.identifier, for: indexPath) as! NameCell
      cell.textDidChange = { [weak self] text in
        self?.presenter?.updateName(text)
      }
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: SelfieCell.identifier, for: indexPath) as! SelfieCell
      cell.hasSelfie = presenter?.hasSelfie ?? false
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
    tableView.deselectRow(at: indexPath, animated: true)
    
    switch indexPath.row {
    case 1: presentSelfieOptions()
    case 2: sendButtonTapped()
    default: break
    }
  }
}

// MARK: - UIImagePickerControllerDelegate
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    if let image = info[.originalImage] as? UIImage {
      presenter?.updateSelfieImage(image)
    }
    runOnMain {
      self.tableView.reloadData()
      picker.dismiss(animated: true)
    }
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    runOnMain {
      picker.dismiss(animated: true)
    }
  }
}

// MARK: - Selfie Helper Methods
private extension MainViewController {
  func presentSelfieOptions() {
    let alert = UIAlertController(title: "Selfie", message: "Elige una opción", preferredStyle: .actionSheet)
    
    if let image = presenter?.currentSelfieImage {
      alert.addAction(UIAlertAction(title: "Ver selfie", style: .default) { [weak self] _ in
        self?.presentSelfiePreview(image: image)
      })
    }
    
    let selfieTitle = (presenter?.hasSelfie ?? false) ? "Retomar selfie" : "Tomar selfie"
    alert.addAction(UIAlertAction(title: selfieTitle, style: .default) { [weak self] _ in
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
  
  func presentCameraOrLibrary() {
#if targetEnvironment(simulator)
    presentPicker(sourceType: .photoLibrary)
#else
    checkCameraPermissionAndPresent()
#endif
  }
  
  func checkCameraPermissionAndPresent() {
    let status = AVCaptureDevice.authorizationStatus(for: .video)
    switch status {
    case .authorized:
      presentPicker(sourceType: .camera)
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
        runOnMain {
          if granted {
            self?.presentPicker(sourceType: .camera)
          } else {
            print("Permission denied")
          }
        }
      }
    case .denied, .restricted:
      print("Permission denied")
    @unknown default:
      break
    }
  }
  
  func presentPicker(sourceType: UIImagePickerController.SourceType) {
    guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
    let picker = UIImagePickerController()
    picker.sourceType = sourceType
    picker.delegate = self
    if sourceType == .camera {
      picker.cameraDevice = .front
    }
    present(picker, animated: true)
  }
}
