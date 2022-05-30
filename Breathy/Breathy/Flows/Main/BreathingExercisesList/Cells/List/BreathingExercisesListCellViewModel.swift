//
//  BreathingExercisesListCellViewModel.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import Foundation

struct BreathingExercisesListCellViewModel {

    // MARK: - Public Properties

    let title: String
    let subtitle: String
    let backgroundAsset: ImageAsset

    // MARK: - Init

    init(breathingExerciseInfo: BreathingExerciseInfo) {
        self.title = breathingExerciseInfo.type.title
        self.subtitle = Self.makeSubtitle(with: breathingExerciseInfo)
        self.backgroundAsset = breathingExerciseInfo.type.backgroundAsset
    }

    // MARK: - Private Static Methods

    private static func makeSubtitle(with breathingExerciseInfo: BreathingExerciseInfo) -> String {
        let patternFormatted = "\(breathingExerciseInfo.inhale)-\(breathingExerciseInfo.hold)-\(breathingExerciseInfo.exhale)"
        if let formattedTime = breathingExerciseInfo.duration.minutesFormatted {
            return "\(patternFormatted) • \(formattedTime)"
        } else {
            return patternFormatted
        }
    }
}

// MARK: - Hashable

extension BreathingExercisesListCellViewModel: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(subtitle)
        hasher.combine(backgroundAsset.name)
    }

    static func == (lhs: BreathingExercisesListCellViewModel, rhs: BreathingExercisesListCellViewModel) -> Bool {
        lhs.title == rhs.title &&
        lhs.subtitle == rhs.subtitle &&
        lhs.backgroundAsset.name == rhs.backgroundAsset.name
    }
}
