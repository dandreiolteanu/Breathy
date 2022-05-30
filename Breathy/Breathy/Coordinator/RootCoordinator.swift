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

    private var mainCoordinator: MainCoordinator?

    // MARK: - Init

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Public Methods
    
    func start() {
        let coordinator = MainCoordinator()
        coordinator.start()

        self.mainCoordinator = coordinator

        show(coordinator: coordinator)
    }
}
