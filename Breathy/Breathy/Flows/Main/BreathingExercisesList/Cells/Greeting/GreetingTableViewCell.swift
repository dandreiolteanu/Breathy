//
//  GreetingTableViewCell.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import UIKit
import SnapKit

final class GreetingTableViewCell: UITableViewCell, Reusable {

    // MARK: - Public Properties

    var viewModel: GreetingCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            subtitleLabel.text = viewModel?.subtitle
        }
    }

    // MARK: - Private Properties

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    // MARK: - Lifecycle

    private func commonInit() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = backgroundColor

        titleLabel.font = .h1SemiBold
        titleLabel.textColor = .primaryText

        subtitleLabel.font = .secondaryTextRegular
        subtitleLabel.textColor = .secondaryText
        subtitleLabel.numberOfLines = 0

        let textStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStackView.axis = .vertical
        textStackView.spacing = .padding
        contentView.addSubview(textStackView)

        textStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().insetBy(.padding2x).priority(999)
            $0.top.equalToSuperview().insetBy(.padding3x).priority(999)
            $0.bottom.equalToSuperview().insetBy(.padding2x).priority(999)
        }
    }
}
