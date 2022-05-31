//
//  BreathingExerciseInfo.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import Foundation

struct BreathingExerciseInfo: Codable {

    // MARK: - Type

    enum `Type`: String, Codable {

        // MARK: - Cases

        case stress
        case sleep
        case happiness

        // MARK: - Properties

        var title: String {
            switch self {
            case .stress:
                return L10n.BreathingInfo.stressTitle
            case .sleep:
                return L10n.BreathingInfo.sleepTitle
            case .happiness:
                return L10n.BreathingInfo.happinessTitle
            }
        }

        var backgroundAsset: ImageAsset {
            switch self {
            case .stress:
                return Asset.imgReduceStress
            case .sleep:
                return Asset.imgBetterSleep
            case .happiness:
                return Asset.imgIncreaseHappiness
            }
        }
    }

    // MARK: - Public Properties

    let type: Type
    let exhale: Int
    let inhale: Int
    let hold: Int
    let repeats: Int

    var duration: TimeInterval {
        let repeatDuration = exhale + inhale + hold
        let totalDuration = repeatDuration * repeats

        return TimeInterval(totalDuration)
    }
}
