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
    private let appCore: AppCore

    // MARK: - Init

    init(window: UIWindow, appCore: AppCore) {
        self.window = window
        self.appCore = appCore
    }

    // MARK: - Public Methods
    
    func start() {
        let coordinator = MainCoordinator(appCore: appCore)
        coordinator.start()

        self.mainCoordinator = coordinator

        show(coordinator: coordinator)
    }
}
