//
//  BreathingCoordinator.swift
//  BreathingExercises
//
//  Created by Andrei Olteanu on 26.05.2022.
//

import UIKit

final class BreathingCoordinator: Coordinator {

    // MARK: - Public Properties

    let mainViewController: UIViewController

    // MARK: - Init
    
    init() {
        let viewController = BreathingExercisesListViewController(viewModel: {
            let viewModel = BreathingExercisesListViewModelImpl()
            return viewModel
        }())

        self.mainViewController = UINavigationController(rootViewController: viewController)
    }
}
