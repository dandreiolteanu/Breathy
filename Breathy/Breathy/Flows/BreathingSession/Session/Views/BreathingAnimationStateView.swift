//
//  BreathingAnimationStateView.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import Combine
import UIKit
import SnapKit

final class BreathingAnimationStateView: UIView {

    // MARK: - Public Properties

    var currentStateCompletionSubject: AnyPublisher<Void, Never> {
        _currentStateCompletionSubject.eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private let circleBorderView = UIView()
    private let holdImageView = UIImageView()
    private let exhaleInhaleImageView = UIImageView()
    private let currentStateDurationLabel = UILabel()

    private var currentRunningAnimators: [UIViewPropertyAnimator] = []
    private var timer: Timer?
    private var currentTime: Int = 0
    private let _currentStateCompletionSubject = PassthroughSubject<Void, Never>()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: .zero)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        circleBorderView.layer.cornerRadius = circleBorderView.bounds.height / 2
    }

    private func commonInit() {
        circleBorderView.backgroundColor = .clear
        circleBorderView.layer.borderWidth = 3
        circleBorderView.layer.borderColor = UIColor.inhaleExhaleBorder.cgColor
        addSubview(circleBorderView)

        exhaleInhaleImageView.alpha = 1.0
        exhaleInhaleImageView.contentMode = .scaleAspectFill
        exhaleInhaleImageView.image = Asset.imgBreathingExhaleInhale.image
        addSubview(exhaleInhaleImageView)

        holdImageView.alpha = 0.0
        holdImageView.contentMode = .scaleAspectFill
        holdImageView.image = Asset.imgBreathingHold.image
        addSubview(holdImageView)

        currentStateDurationLabel.font = .h1Bold
        currentStateDurationLabel.textColor = .primaryTextDark
        addSubview(currentStateDurationLabel)

        circleBorderView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        [holdImageView, exhaleInhaleImageView].forEach {
            $0.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(1.20)
                $0.height.equalTo(snp.width).multipliedBy(1.20)
            }
        }

        currentStateDurationLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    // MARK: - Public Methods

    func transition(to state: BreathingSessionViewModelImpl.BreathingState) {
        switch state {
        case .inhale(let seconds):
            inhaleAnimator(seconds: seconds)

        case .hold(let seconds):
            holdAnimator(seconds: seconds)

        case .exhale(let seconds):
            exhaleAnimator(seconds: seconds)
        }

        setupTimer(seconds: state.duration)
    }

    func resume() {
        currentRunningAnimators.forEach {
            $0.startAnimation()
        }

        setupTimer(seconds: currentTime)
    }

    func pause() {
        currentRunningAnimators.forEach {
            $0.pauseAnimation()
        }

        timer?.invalidate()
        timer = nil
    }

    // MARK: - Private Methods

    private func inhaleAnimator(seconds: Int) {
        exhaleInhaleImageView.transform = CGAffineTransform(scaleX: .inhaleStart, y: .inhaleStart)

        let alphaAnimator = UIViewPropertyAnimator(duration: 0.44, curve: .easeOut) {
            self.holdImageView.alpha = 0.0
            self.exhaleInhaleImageView.alpha = 1.0
            self.circleBorderView.layer.borderColor = UIColor.inhaleExhaleBorder.cgColor
            
        }
        alphaAnimator.addCompletion { _ in
            self.currentRunningAnimators.removeAll(where: { $0 === alphaAnimator })
        }
        
        let animator = UIViewPropertyAnimator(duration: TimeInterval(seconds), curve: .linear) {
            self.exhaleInhaleImageView.transform = CGAffineTransform(scaleX: .inhaleEnd, y: .inhaleEnd)
            self.holdImageView.transform = CGAffineTransform(scaleX: .inhaleEnd, y: .inhaleEnd)
        }
        animator.addCompletion { _ in
            self.currentRunningAnimators.removeAll { $0 === animator }
        }

        currentRunningAnimators.append(alphaAnimator)
        currentRunningAnimators.append(animator)
        alphaAnimator.startAnimation()
        animator.startAnimation()
    }

    private func exhaleAnimator(seconds: Int) {
        exhaleInhaleImageView.transform = CGAffineTransform(scaleX: .inhaleEnd, y: .inhaleEnd)

        let alphaAnimator = UIViewPropertyAnimator(duration: 0.44, curve: .easeOut) {
            self.exhaleInhaleImageView.alpha = 1.0
            self.holdImageView.alpha = 0.0
            self.circleBorderView.layer.borderColor = UIColor.inhaleExhaleBorder.cgColor
        }
        alphaAnimator.addCompletion { _ in
            self.currentRunningAnimators.removeAll { $0 === alphaAnimator }
        }

        let animator = UIViewPropertyAnimator(duration: TimeInterval(seconds), curve: .linear) {
            self.exhaleInhaleImageView.transform = CGAffineTransform(scaleX: .inhaleStart, y: .inhaleStart)
            self.holdImageView.transform = CGAffineTransform(scaleX: .inhaleStart, y: .inhaleStart)
        }
        animator.addCompletion { _ in
            self.currentRunningAnimators.removeAll { $0 === animator }
        }

        currentRunningAnimators.append(alphaAnimator)
        currentRunningAnimators.append(animator)
        alphaAnimator.startAnimation()
        animator.startAnimation()
    }

    private func holdAnimator(seconds: Int) {
        let alphaAnimator = UIViewPropertyAnimator(duration: 0.44, curve: .easeOut) {
            self.exhaleInhaleImageView.alpha = 0.0
            self.holdImageView.alpha = 1.0
            self.circleBorderView.layer.borderColor = UIColor.holdBorder.cgColor
        }
        alphaAnimator.addCompletion { _ in
            self.currentRunningAnimators.removeAll { $0 === alphaAnimator }
        }

        currentRunningAnimators.append(alphaAnimator)
        alphaAnimator.startAnimation()
    }

    private func setupTimer(seconds: Int) {
        timer?.invalidate()
        timer = nil

        self.currentTime = seconds
        currentStateDurationLabel.text = "\(seconds)"
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.currentTime -= 1

            guard self.currentTime > 0 else {
                self.timer?.invalidate()
                self.timer = nil
                self._currentStateCompletionSubject.send(())
                return
            }

            self.currentStateDurationLabel.text = "\(self.currentTime)"
        })
    }
}

// MARK: - Constats

private extension CGFloat {
    static let exhaleEndAuraAlpha: CGFloat = 0.85
    static let exhaleEndAlpha: CGFloat = 0.45
    static let inhaleStart: CGFloat = 0.45
    static let inhaleEnd: CGFloat = 1.0
}

private extension UIColor {
    static let inhaleExhaleBorder: UIColor = .primaryText.withAlphaComponent(0.2)
    static let holdBorder: UIColor = .progressBarColor.withAlphaComponent(0.2)
}
