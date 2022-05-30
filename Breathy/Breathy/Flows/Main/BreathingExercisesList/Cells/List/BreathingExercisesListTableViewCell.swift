//
//  BreathingExercisesListTableViewCell.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import UIKit
import SnapKit

final class BreathingExercisesListTableViewCell: UITableViewCell, Reusable, SelectionAnimated {

    // MARK: - Public Properties

    var viewModel: BreathingExercisesListCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            subtitleLabel.text = viewModel?.subtitle
            backgroundImageView.image = viewModel?.backgroundAsset.image
        }
    }

    // MARK: - Private Properties

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let playImageView = UIImageView()
    private let backgroundImageView = UIImageView()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    // MARK: - Base Class Overrides

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        animate(view: containerView, on: selected)
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        animate(view: containerView, on: highlighted)
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

        backgroundImageView.contentMode = .scaleAspectFill
        containerView.addSubview(backgroundImageView)

        titleLabel.font = .bodyMedium
        titleLabel.textColor = .primaryText

        subtitleLabel.font = .tertiaryTextRegular
        subtitleLabel.textColor = .secondaryText

        playImageView.image = Asset.icnPlay.image
        playImageView.setContentHuggingPriority(.required, for: .horizontal)

        let textStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStackView.axis = .vertical
        textStackView.spacing = .padding

        let containerStackView = UIStackView(arrangedSubviews: [textStackView, playImageView])
        containerStackView.axis = .horizontal
        containerStackView.spacing = .padding
        containerStackView.alignment = .center
        containerView.addSubview(containerStackView)

        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().insetBy(.padding2x).priority(999)
            $0.top.bottom.equalToSuperview().insetBy(.padding).priority(999)
        }
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().insetBy(.padding2x)
            $0.top.bottom.equalToSuperview().insetBy(.padding20)
        }
    }
}
