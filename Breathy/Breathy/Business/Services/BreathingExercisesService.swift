//
//  BreathingExercisesService.swift
//  Breathy
//
//  Created by Andrei Olteanu on 31.05.2022.
//

import Foundation

protocol BreathingExercisesService: AnyObject {
    var exercises: [BreathingExerciseInfo] { get }
}

final class BreathingExercisesServiceMock: BreathingExercisesService {

    // MARK: - Public Properties

    let exercises = [stressExercise, sleepExercise, happinessExercise]

    // MARK: - Private Static Properties

    private static let stressExercise = BreathingExerciseInfo(type: .stress, exhale: 4, inhale: 4, hold: 4, repeats: 6)
    private static let sleepExercise = BreathingExerciseInfo(type: .sleep, exhale: 8, inhale: 4, hold: 4, repeats: 6)
    private static let happinessExercise = BreathingExerciseInfo(type: .happiness, exhale: 6, inhale: 4, hold: 4, repeats: 6)
}
