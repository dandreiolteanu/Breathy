//
//  BreathingSessionViewController.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import AVFoundation
import Combine
import UIKit
import SnapKit

final class BreathingSessionViewController: BaseViewController {
    
    // MARK: - Private properties

    private let viewModel: BreathingSessionViewModel

    private let auraBackgroundImageView = UIImageView()
    private let animationStateView = BreathingAnimationStateView()
    private let currentStateLabel = UILabel()
    private lazy var exerciseDurationView = BreathingSessionDurationView(totalTime: viewModel.inputs.totalTime)

    private var hapticEngine = BreathingExerciseHapticEngine()
    private var audioPlayer: AVAudioPlayer?

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: BreathingSessionViewModel) {
        self.viewModel = viewModel

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        setupBindings()

        exerciseDurationView.startCountdown()
        viewModel.outputs.goToNextInSession()
        playAudio()
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = viewModel.inputs.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Asset.icnClose.image.withRenderingMode(.alwaysOriginal),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(closeButtonTouched))
        view.backgroundColor = .primaryBackground

        view.addSubview(animationStateView)

        view.addSubview(exerciseDurationView)

        currentStateLabel.font = .h1Bold
        currentStateLabel.textColor = .primaryText
        currentStateLabel.textAlignment = .center
        view.addSubview(currentStateLabel)
    }

    private func setupConstraints() {
        animationStateView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(view.snp.width).multipliedBy(0.5)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }
        
        currentStateLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().insetBy(.padding3x)
            $0.top.equalTo(animationStateView.snp.bottom).offsetBy(.padding5x)
            $0.bottom.lessThanOrEqualTo(exerciseDurationView.snp.top)
        }

        exerciseDurationView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().insetBy(.padding3x)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).insetBy(.padding7x)
        }
    }

    private func setupBindings() {
        animationStateView.currentStateCompletionSubject
            .sink { [weak self] in
                self?.viewModel.outputs.goToNextInSession()
            }
            .store(in: &subscriptions)

        viewModel.inputs.sessionTransition
            .sink { [weak self] state in
                self?.currentStateLabel.text = state.displayValue
                
                self?.animationStateView.transition(to: state)
                self?.hapticEngine?.transition(to: state)
            }
            .store(in: &subscriptions)

        viewModel.inputs.sessionShouldPause
            .sink { [weak self] in
                self?.pause()
            }
            .store(in: &subscriptions)

        viewModel.inputs.sessionShouldResume
            .sink { [weak self] in
                self?.resume()
            }
            .store(in: &subscriptions)
    }

    // MARK: - Private Methods

    private func playAudio() {
        guard let url = Bundle.main.url(forResource: "breathing-audio", withExtension: "mp3") else { return }
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.numberOfLoops = 0
        audioPlayer?.volume = 0.6

        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)
        try? AVAudioSession.sharedInstance().setActive(true)

        audioPlayer?.play()
    }

    private func pause() {
        exerciseDurationView.pause()
        animationStateView.pause()
        audioPlayer?.pause()
        hapticEngine?.pause()
    }

    private func resume() {
        exerciseDurationView.resume()
        animationStateView.resume()
        audioPlayer?.play()
    }

    @objc private func closeButtonTouched() {
        viewModel.outputs.closeTouched()
    }
}
