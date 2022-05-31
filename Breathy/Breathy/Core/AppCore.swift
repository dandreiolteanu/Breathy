//
//  AppCore.swift
//  Breathy
//
//  Created by Andrei Olteanu on 31.05.2022.
//

import Foundation

final class AppCore {

    // MARK: - Public Properties

    let breathingExercisesService: BreathingExercisesService
    
    // MARK: - Init

    init() {
        self.breathingExercisesService = BreathingExercisesServiceMock()
    }
}
