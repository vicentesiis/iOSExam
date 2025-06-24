//
//  SelfieCell.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit

final class SelfieCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "SelfieCell"

    var hasSelfie: Bool = false {
        didSet { updateUI() }
    }

    // MARK: - UI Components
    private let selfieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        contentView.addSubview(selfieLabel)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupConstraints() {
        selfieLabel.pinEdgesToSuperview(withInsets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }

    private func updateUI() {
        selfieLabel.text = hasSelfie ? "Opciones" : "Tomar selfie"
    }
}
