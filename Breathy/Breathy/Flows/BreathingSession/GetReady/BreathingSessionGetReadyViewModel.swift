//
//  BreathingSessionGetReadyViewModel.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import Foundation
import CoreHaptics

protocol BreathingSessionGetReadyViewModelFlowDelegate: AnyObject {
    func shouldClose()
    func shouldStartExercise()
}

protocol BreathingSessionGetReadyViewModelInputs {
    var currentTime: Int { get }
}

protocol BreathingSessionGetReadyViewModelOutputs {
    func onAppear()
    func didPressClose()
}

protocol BreathingSessionGetReadyViewModel: ObservableObject {
    var inputs: BreathingSessionGetReadyViewModelInputs { get }
    var outputs: BreathingSessionGetReadyViewModelOutputs { get }
}

final class BreathingSessionGetReadyViewModelImpl: BreathingSessionGetReadyViewModel, BreathingSessionGetReadyViewModelInputs, BreathingSessionGetReadyViewModelOutputs {

    // MARK: - FlowDelegate
    
    weak var flowDelegate: BreathingSessionGetReadyViewModelFlowDelegate?

    // MARK: - Inputs

    var inputs: BreathingSessionGetReadyViewModelInputs { self }

    @Published var currentTime: Int

    // MARK: - Outputs

    var outputs: BreathingSessionGetReadyViewModelOutputs { self }

    // MARK: - Private Properties

    private let getReadyDuration: Int
    private var timer: Timer?
//    private var hapticEngine: BreathingExerciseHapticEngine?
//    private let isMuted = !UserDefaultsManager.shared.breathingVibrateEnabled
    
    // MARK: - Init
    
    init(getReadyDuration: Int) {
        self.getReadyDuration = getReadyDuration
        self.currentTime = getReadyDuration
    }

    // MARK: - Public Methods

    func onAppear() {
//        if CHHapticEngine.capabilitiesForHardware().supportsHaptics {
//            hapticEngine = try? BreathingExerciseHapticEngine(isMuted: isMuted)
//            try? hapticEngine?.playGetReady(seconds: currentTime)
//        }

        currentTime = getReadyDuration

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }

            guard self.currentTime - 1 > 0 else {
                self.timer?.invalidate()
                self.timer = nil
                self.flowDelegate?.shouldStartExercise()
                return
            }

            self.currentTime -= 1
        })
    }

    func didPressClose() {
        timer?.invalidate()
        timer = nil

        flowDelegate?.shouldClose()
    }
}
