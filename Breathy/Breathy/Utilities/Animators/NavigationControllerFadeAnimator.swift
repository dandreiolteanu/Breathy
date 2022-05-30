//
//  NavigationControllerFadeAnimator.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import UIKit

final class NavigationControllerFadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - Public Properties

    var operation: UINavigationController.Operation

    // MARK: - Init

    init(operation: UINavigationController.Operation) {
        self.operation = operation

        super.init()
    }

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
        else { return }

        let containerView = transitionContext.containerView

        if operation == .push {
            containerView.addSubview(toViewController.view)
            containerView.addSubview(fromViewController.view)

            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           delay: 0,
                           options: [.curveEaseOut, .beginFromCurrentState],
                           animations: {
                fromViewController.view.alpha = 0
            },
                           completion: { _ in
                transitionContext.completeTransition(true)
                fromViewController.view.removeFromSuperview()
            })
        } else if operation == .pop {
            containerView.addSubview(toViewController.view)
            containerView.addSubview(fromViewController.view)

            toViewController.view.alpha = 1

            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           delay: 0,
                           options: [.curveEaseOut, .beginFromCurrentState],
                           animations: {
                fromViewController.view.alpha = 0
            },
                           completion: { _ in
                transitionContext.completeTransition(true)
                fromViewController.view.removeFromSuperview()
            })
        }
    }
}
