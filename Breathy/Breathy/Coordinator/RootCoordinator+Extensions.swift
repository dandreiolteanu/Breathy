//
//  RootCoordinator+Extensions.swift
//  BreathingExercises
//
//  Created by Andrei Olteanu on 26.05.2022.
//

import UIKit

extension RootCoordinator {

    // MARK: - Set root

    var root: UIViewController? {
        return window?.rootViewController
    }

    func setRoot(to viewController: UIViewController?, animated: Bool = false, completion: (() -> Void)? = nil) {
        guard let viewController = viewController else { return }

        guard root != viewController else { return }

        func changeRoot(to viewController: UIViewController) {
            window?.rootViewController = viewController
        }

        if animated, let snapshotView = window?.snapshotView(afterScreenUpdates: true) {
            viewController.view.addSubview(snapshotView)

            changeRoot(to: viewController)

            UIView.animate(withDuration: 0.33, animations: {
                snapshotView.alpha = 0.0
            }, completion: { _ in
                snapshotView.removeFromSuperview()
                completion?()
            })
        } else {
            changeRoot(to: viewController)
            completion?()
        }
    }

    // MARK: - Show flows

    func show(coordinator: Coordinator, animated: Bool = true, completion: (() -> Void)? = nil) {
        setRoot(to: coordinator.mainViewController, animated: animated) {
            completion?()
        }
    }
}
