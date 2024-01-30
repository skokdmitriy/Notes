//
//  MainTableViewCell.swift
//  Notes
//
//  Created by Дмитрий Скок on 30.01.2024.
//

import UIKit
import SnapKit

final class NoteTableViewCell: UITableViewCell {

    private lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(text: String) {
        noteLabel.text = text
    }

    private func setupLayout() {
        addSubview(noteLabel)

        noteLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }

}
