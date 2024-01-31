//
//  MainTableViewCell.swift
//  Notes
//
//  Created by Дмитрий Скок.
//

import UIKit
import SnapKit

final class NoteTableViewCell: UITableViewCell {
    // MARK: - Views

    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func configureCell(text: String) {
        noteLabel.text = text
    }

    // MARK: - Private functions

    private func setupLayout() {
        addSubview(noteLabel)

        noteLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
