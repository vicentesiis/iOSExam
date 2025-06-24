//
//  SelfieCell.swift
//  iOSExam
//
//  Created by Vicente Cantu on 23/06/25.
//

import UIKit

protocol SelfieCellDelegate: AnyObject {
    func selfieCellDidRequestCamera(_ cell: SelfieCell)
}

final class SelfieCell: UITableViewCell {
    static let identifier = "SelfieCell"

    weak var delegate: SelfieCellDelegate?

    private let selfieLabel: UILabel = {
        let label = UILabel()
        label.text = "Tomar Selfe"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        contentView.addSubview(selfieLabel)
        setupConstraints()

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        contentView.addGestureRecognizer(tap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            selfieLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            selfieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            selfieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            selfieLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    @objc private func didTapCell() {
        delegate?.selfieCellDidRequestCamera(self)
    }
}
