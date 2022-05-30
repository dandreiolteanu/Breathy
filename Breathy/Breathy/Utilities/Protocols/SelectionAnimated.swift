//
//  SelectionAnimated.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import UIKit

protocol SelectionAnimated {
    func animate(view: UIView, on isSelected: Bool)
}

extension SelectionAnimated {

    func animate(view: UIView, on isSelected: Bool) {
        UIView.animate(withDuration: 0.33,
                       delay: 0.0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut,
                       animations: {
            view.transform = isSelected ? .scale : .identity
        }, completion: nil)
    }
}

extension SelectionAnimated where Self: UITableViewCell {

    func animate(on isSelected: Bool) {
        animate(view: self, on: isSelected)
    }
}

extension SelectionAnimated where Self: UICollectionViewCell {

    func animate(on isSelected: Bool) {
        animate(view: self, on: isSelected)
    }
}

extension SelectionAnimated where Self: UIControl {

    func animate(on isSelected: Bool) {
        animate(view: self, on: isSelected)
    }
}

// MARK: - Constants

private extension CGFloat {
    static let scaleFactor: CGFloat = 0.98
}

private extension CGAffineTransform {
    static let scale = CGAffineTransform(scaleX: .scaleFactor, y: .scaleFactor)
}
