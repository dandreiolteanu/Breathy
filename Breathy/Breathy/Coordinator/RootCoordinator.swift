//
//  RootCoordinator.swift
//  BreathingExercises
//
//  Created by Andrei Olteanu on 26.05.2022.
//

import UIKit

final class RootCoordinator {

    // MARK: - Public Properties

    weak var window: UIWindow?

    // MARK: - Private Properties

    private var breathingCoordinator: BreathingCoordinator?

    // MARK: - Init

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - 
    
    func start() {
        let coordinator = BreathingCoordinator()
        self.breathingCoordinator = coordinator

        show(coordinator: coordinator)
    }
}
