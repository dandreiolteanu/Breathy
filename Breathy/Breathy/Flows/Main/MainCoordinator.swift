//
//  MainCoordinator.swift
//  BreathingExercises
//
//  Created by Andrei Olteanu on 26.05.2022.
//

import UIKit

final class MainCoordinator: Coordinator {

    // MARK: - Public Properties

    var childCoordinators: [Coordinator] = []
    var mainViewController: UIViewController?

    // MARK: - Private Properties

    private let appCore: AppCore

    // MARK: - Init

    init(appCore: AppCore) {
        self.appCore = appCore
    }

    // MARK: - Public Methods

    func start() {
        let viewController = BreathingExercisesListViewController(viewModel: {
            let viewModel = BreathingExercisesListViewModelImpl(breathingExercisesService: appCore.breathingExercisesService)
            viewModel.flowDelegate = self
            return viewModel
        }())

        self.mainViewController = UINavigationController(rootViewController: viewController)
    }
}

// MARK: - BreathingExercisesListFlowDelegate

extension MainCoordinator: BreathingExercisesListFlowDelegate {

    func didSelectBreathingExerciseInfo(on viewModel: BreathingExercisesListViewModel, breathingExerciseInfo: BreathingExerciseInfo) {
        let breathingSessionCoordinator = BreathingSessionCoordinator(breathingExerciseInfo: breathingExerciseInfo)
        breathingSessionCoordinator.flowDelegate = self
        breathingSessionCoordinator.start()

        appendChild(breathingSessionCoordinator)

        guard let breathingSessionMainViewController = breathingSessionCoordinator.mainViewController else { return }
        mainViewController?.present(breathingSessionMainViewController, animated: true)
    }
}

extension MainCoordinator: BreathingSessionCoordinatorFlowDelegate {

    func didFinish(on coordinator: BreathingSessionCoordinator) {
        childCoordinators.first { $0 === coordinator }?.mainViewController?.dismiss(animated: true) { [weak self] in
            self?.removeChild(coordinator)
        }
    }
}
