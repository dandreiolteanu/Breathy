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

final class BreathingSessionCoordinator: NSObject, Coordinator {

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

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.delegate = self

        mainViewController = navigationController
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
        let discardAction = UIAlertAction(title: L10n.BreathingSession.alertDiscardAction, style: .destructive) { [weak self] _ in
            guard let self = self else { return }
        
            self.flowDelegate?.didFinish(on: self)
        }

        let continueAction = UIAlertAction(title: L10n.BreathingSession.alertContinueAction, style: .default) { [weak viewModel] _ in
            viewModel?.outputs.resume()
        }

        let alertController = UIAlertController(title: L10n.BreathingSession.alertTitle, message: L10n.BreathingSession.alertMessage, preferredStyle: .alert)
        alertController.addAction(discardAction)
        alertController.addAction(continueAction)
        alertController.preferredAction = continueAction

        mainViewController?.present(alertController, animated: true)
    }
}

// MARK: - UINavigationControllerDelegate

extension BreathingSessionCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        NavigationControllerFadeAnimator(operation: operation)
    }
}
