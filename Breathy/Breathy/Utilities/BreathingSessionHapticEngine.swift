//
//  BreathingSessionHapticEngine.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import CoreHaptics

final class BreathingExerciseHapticEngine {

    // MARK: - Private Properties

    private let engine: CHHapticEngine
    private var player: CHHapticPatternPlayer?

    // MARK: - Init

    init?() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics, let engine = try? CHHapticEngine() else {
            return nil
        }

        self.engine = engine
    }

    // MARK: - Public Methods

    func transition(to nextState: BreathingSessionViewModelImpl.BreathingState) {
        try? play(with: nextState.hapticEvents)
    }

    func playGetReady(seconds: Int) {
        try? play(with: BreathingSessionViewModelImpl.BreathingState.hold(seconds: seconds).hapticEvents)
    }

    func pause() {
        try? player?.stop(atTime: CHHapticTimeImmediate)
        engine.stop()
    }

    // MARK: - Private Methods

    private func play(with events: [CHHapticEvent]) throws {
        let pattern = try CHHapticPattern(events: events, parameters: [])
        try engine.start()
        player = try? engine.makePlayer(with: pattern)
        try? player?.start(atTime: CHHapticTimeImmediate)

        engine.notifyWhenPlayersFinished { _ in
            return .stopEngine
        }
    }
}

// MARK: - Constants

private extension BreathingSessionViewModelImpl.BreathingState {

    var hapticEvents: [CHHapticEvent] {
        var events: [CHHapticEvent] = []
        var currentTime: TimeInterval = 0.0

        switch self {
        case .inhale(let seconds),
             .exhale(let seconds):
            if seconds > 2 {
                events.append(
                    CHHapticEvent(eventType: .hapticContinuous,
                                  parameters: [.moderateIntensity, .moderateSharpness],
                                  relativeTime: currentTime,
                                  duration: 1.5)
                )
                currentTime += 2

                for _ in 0..<seconds-2 {
                    events.append(
                        CHHapticEvent(eventType: .hapticTransient,
                                      parameters: [.moderateIntensity, .moderateSharpness],
                                      relativeTime: currentTime)
                    )
                    currentTime += 1
                }
            } else {
                events.append(
                    CHHapticEvent(eventType: .hapticContinuous,
                                  parameters: [.moderateIntensity, .moderateSharpness],
                                  relativeTime: currentTime,
                                  duration: TimeInterval(seconds))
                )
                currentTime += TimeInterval(seconds)
            }
        case .hold(let seconds):
            for _ in 0..<seconds {
                events.append(
                    CHHapticEvent(eventType: .hapticContinuous,
                                  parameters: [.holdIntensity, .holdSharpness],
                                  relativeTime: currentTime,
                                  duration: 0.15)
                )
                currentTime += 1
            }
        }

        return events
    }
}

private extension CHHapticEventParameter {
    static let holdIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.35)
    static let holdSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.35)
    static let moderateIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.45)
    static let moderateSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.35)
}
