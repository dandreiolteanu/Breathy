//
//  ComingSoonTableViewCell.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import UIKit
import SnapKit

final class ComingSoonTableViewCell: UITableViewCell, Reusable {

    // MARK: - Public Properties

    var viewModel: ComingSoonCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            subtitleLabel.text = viewModel?.subtitle
        }
    }

    // MARK: - Private Properties

    private let containerView = UIView()
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

        containerView.backgroundColor = .secondaryBackground
        containerView.layer.cornerRadius = .padding1xHalf
        containerView.clipsToBounds = true
        contentView.addSubview(containerView)

        titleLabel.font = .bodyMedium
        titleLabel.textColor = .primaryText

        subtitleLabel.font = .tertiaryTextRegular
        subtitleLabel.textColor = .secondaryText
        subtitleLabel.numberOfLines = 0

        let iconImageView = UIImageView(image: Asset.icnComingSoon.image)
        iconImageView.setContentHuggingPriority(.required, for: .horizontal)

        let textStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStackView.axis = .vertical
        textStackView.spacing = .padding

        let containerStackView = UIStackView(arrangedSubviews: [textStackView, iconImageView])
        containerStackView.axis = .horizontal
        containerStackView.spacing = .padding
        containerStackView.alignment = .center
        containerView.addSubview(containerStackView)

        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().insetBy(.padding2x).priority(999)
            $0.top.equalToSuperview().insetBy(.padding2x).priority(999)
            $0.bottom.equalToSuperview().insetBy(.padding).priority(999)
        }
        containerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().insetBy(.padding2x)
            $0.top.bottom.equalToSuperview().insetBy(.padding20)
        }
    }
}
