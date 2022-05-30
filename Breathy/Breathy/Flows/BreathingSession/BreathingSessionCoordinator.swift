//
//  BreathingSessionCoordinator.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import UIKit

protocol BreathingSessionCoordinatorFlowDelegate: AnyObject {
    func didFinish(on coordinator: BreathingSessionCoordinator)
}

final class BreathingSessionCoordinator: Coordinator {

    // MARK: - Public Properties

    weak var flowDelegate: BreathingSessionCoordinatorFlowDelegate?

    var childCoordinators: [Coordinator] = []
    var mainViewController: UIViewController?

    private var navigationController: UINavigationController? {
        mainViewController as? UINavigationController
    }

    // MARK: - Private Properties

    private let breathingExerciseInfo: BreathingExerciseInfo

    // MARK: - Init

    init(breathingExerciseInfo: BreathingExerciseInfo) {
        self.breathingExerciseInfo = breathingExerciseInfo
    }

    // MARK: - Public Methods
    
    func start() {
        let viewModel = BreathingSessionGetReadyViewModelImpl(getReadyDuration: 3)
        viewModel.flowDelegate = self

        let viewController = BreathingSessionGetReadyView(viewModel: viewModel).asUIViewController
        viewController.view.backgroundColor = .primaryBackground
        mainViewController = UINavigationController(rootViewController: viewController)
        mainViewController?.modalPresentationStyle = .fullScreen
    }
}

// MARK: - BreathingSessionGetReadyViewModelFlowDelegate

extension BreathingSessionCoordinator: BreathingSessionGetReadyViewModelFlowDelegate {

    func shouldClose() {
        flowDelegate?.didFinish(on: self)
    }

    func shouldStartExercise() {
        let viewModel = BreathingSessionViewModelImpl(breathingExerciseInfo: breathingExerciseInfo)
        viewModel.flowDelegate = self

        let viewController = BreathingSessionViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - BreathingSessionFlowDelegate

extension BreathingSessionCoordinator: BreathingSessionFlowDelegate {

    func didFinishSession(on viewModel: BreathingSessionViewModel) {
        flowDelegate?.didFinish(on: self)
    }

    func didPressClose(on viewModel: BreathingSessionViewModel) {
        flowDelegate?.didFinish(on: self)
    }
}
