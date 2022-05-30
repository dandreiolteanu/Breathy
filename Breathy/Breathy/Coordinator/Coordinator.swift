//
//  Coordinator.swift
//  BreathingExercises
//
//  Created by Andrei Olteanu on 26.05.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var mainViewController: UIViewController? { get }

    func appendChild(_ coordinator: Coordinator)
    func removeChild(_ coordinator: Coordinator)
    func start()
}

extension Coordinator {

    func appendChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}
