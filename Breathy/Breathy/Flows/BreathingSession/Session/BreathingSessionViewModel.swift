//
//  BreathingSessionViewModel.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import Foundation
import Combine

protocol BreathingSessionFlowDelegate: AnyObject {
    func didFinishSession(on viewModel: BreathingSessionViewModel)
    func didPressClose(on viewModel: BreathingSessionViewModel)
}

protocol BreathingSessionViewModelInputs {
    var title: String { get }
    var audioUrl: String? { get }
    var totalTime: TimeInterval { get }
    var breathingSessionQueue: Queue<BreathingSessionViewModelImpl.BreathingState> { get }
    var sessionTransition: AnyPublisher<BreathingSessionViewModelImpl.BreathingState, Never> { get }
    var sessionShouldPause: AnyPublisher<Void, Never> { get }
    var sessionShouldResume: AnyPublisher<Void, Never> { get }
}

protocol BreathingSessionViewModelOutputs {
    func pause()
    func resume()
    func goToNextInSession()
    func sessionFinished()
    func closeTouched()
}

protocol BreathingSessionViewModel: AnyObject {
    var inputs: BreathingSessionViewModelInputs { get }
    var outputs: BreathingSessionViewModelOutputs { get }
}

final class BreathingSessionViewModelImpl: BreathingSessionViewModel, BreathingSessionViewModelInputs, BreathingSessionViewModelOutputs {

    // MARK: - BreathingState

    enum BreathingState: Equatable {

        // MARK: - Cases

        case inhale(seconds: Int)
        case exhale(seconds: Int)
        case hold(seconds: Int)

        // MARK: - Public Properties

        var displayValue: String {
            switch self {
            case .inhale:
                return L10n.BreathingSession.inhale
            case .exhale:
                return L10n.BreathingSession.exhale
            case .hold:
                return L10n.BreathingSession.hold
            }
        }

        var duration: Int {
            switch self {
            case .inhale(let seconds),
                 .exhale(let seconds),
                 .hold(let seconds):
                return seconds
            }
        }
    }

    // MARK: - FlowDelegate
    
    weak var flowDelegate: BreathingSessionFlowDelegate?

    // MARK: - Inputs

    var inputs: BreathingSessionViewModelInputs { self }

    let title: String
    let audioUrl: String?
    let totalTime: TimeInterval
    let breathingSessionQueue: Queue<BreathingState>

    var sessionTransition: AnyPublisher<BreathingState, Never> {
        _sessionTransition.eraseToAnyPublisher()
    }

    var sessionShouldPause: AnyPublisher<Void, Never> {
        _sessionShouldPause.eraseToAnyPublisher()
    }

    var sessionShouldResume: AnyPublisher<Void, Never> {
        _sessionShouldResume.eraseToAnyPublisher()
    }

    // MARK: - Outputs
    
    var outputs: BreathingSessionViewModelOutputs { self }

    // MARK: - Private Properties

    private let _sessionTransition = PassthroughSubject<BreathingState, Never>()
    private let _sessionShouldPause = PassthroughSubject<Void, Never>()
    private let _sessionShouldResume = PassthroughSubject<Void, Never>()
    
    // MARK: - Init
    
    init(breathingExerciseInfo: BreathingExerciseInfo) {
        self.title = breathingExerciseInfo.type.title
        self.audioUrl = nil
        self.breathingSessionQueue = Queue<BreathingState>()
        self.totalTime = breathingExerciseInfo.duration

        Self.setupSessionQueue(inhale: breathingExerciseInfo.inhale,
                               exhale: breathingExerciseInfo.exhale,
                               hold: breathingExerciseInfo.hold,
                               repeats: breathingExerciseInfo.repeats).forEach {
            breathingSessionQueue.enqueue(element: $0)
        }
    }

    // MARK: - Public Methods

    func pause() {
        _sessionShouldPause.send(())
    }

    func resume() {
        _sessionShouldResume.send(())
    }

    func goToNextInSession() {
        guard let nextState = breathingSessionQueue.dequeue() else {
            flowDelegate?.didFinishSession(on: self)
            return
        }

        _sessionTransition.send(nextState)
    }

    func sessionFinished() {
        flowDelegate?.didFinishSession(on: self)
    }

    func closeTouched() {
        pause()

        flowDelegate?.didPressClose(on: self)
    }

    // MARK: - Private Static Methods

    private static func setupSessionQueue(inhale: Int, exhale: Int, hold: Int, repeats: Int) -> [BreathingState] {
        guard inhale > 0, exhale > 0, repeats > 0 else { return [] }

        var session = [BreathingState]()

        for _ in 0..<repeats {
            session.append(.inhale(seconds: inhale))

            if hold > 0 {
                session.append(.hold(seconds: hold))
            }

            session.append(.exhale(seconds: exhale))
        }
        
        return session
    }
}
