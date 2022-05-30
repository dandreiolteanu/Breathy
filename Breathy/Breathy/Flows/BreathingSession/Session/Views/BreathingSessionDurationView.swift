//
//  BreathingSessionDurationView.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import UIKit
import SnapKit

final class BreathingSessionDurationView: UIView {

    // MARK: - Private Properties

    private let elapsedTimeLabel = UILabel()
    private let totalTimeLabel = UILabel()
    private let progressView = UIProgressView()

    private let totalTime: TimeInterval
    private var timer: Timer?

    private(set) var elapsedTime = 0.0 {
        didSet {
            guard elapsedTime <= totalTime, totalTime > 0 else {
                timer?.invalidate()
                timer = nil
                return
            }

            progressView.setProgress(Float(elapsedTime / totalTime), animated: true)
            elapsedTimeLabel.text = elapsedTime.hourMinuteSecondFormatted
        }
    }

    // MARK: - Init

    init(totalTime: TimeInterval) {
        self.totalTime = totalTime

        super.init(frame: .zero)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    private func commonInit() {
        backgroundColor = .clear

        elapsedTimeLabel.text = elapsedTime.hourMinuteSecondFormatted
        elapsedTimeLabel.font = .tertiaryTextMedium
        elapsedTimeLabel.textColor = .primaryText

        totalTimeLabel.text = totalTime.hourMinuteSecondFormatted
        totalTimeLabel.font = .tertiaryTextMedium
        totalTimeLabel.textColor = .primaryText

        let timesStackView = UIStackView()
        timesStackView.alignment = .fill
        timesStackView.distribution = .equalSpacing
        timesStackView.spacing = .padding
        timesStackView.axis = .horizontal
        timesStackView.addArrangedSubview(elapsedTimeLabel)
        timesStackView.addArrangedSubview(totalTimeLabel)

        progressView.layer.cornerRadius = 2
        progressView.backgroundColor = .primaryText.withAlphaComponent(0.2)
        progressView.trackTintColor = .primaryText.withAlphaComponent(0.2)
        progressView.progressTintColor = .progressBarColor
        progressView.snp.makeConstraints {
            $0.height.equalTo(4)
        }

        let stackView = UIStackView()
        stackView.spacing = .padding
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.addArrangedSubview(progressView)
        stackView.addArrangedSubview(timesStackView)
        addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Public Methods

    func startCountdown() {
        guard timer == nil else { return }

        let timeInterval = 0.1
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] _ in
            self?.elapsedTime += timeInterval
        })
    }

    func resume() {
        startCountdown()
    }

    func pause() {
        timer?.invalidate()
        timer = nil
    }
}
