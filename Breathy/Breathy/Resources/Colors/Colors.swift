//
//  Colors.swift
//  Breathy
//
//  Created by Andrei Olteanu on 26.05.2022.
//

import UIKit.UIColor

/// All colors used in the app are defined here.
/// Don't forget to add the color in Colors.xcassets as well with the same name as the case's name.
private enum Color: String {
    case primaryBackground
}

// MARK: - Colors

extension UIColor {
    static let primaryBackground = UIColor.initialize(with: .primaryBackground)
}

// MARK: - Helpers

private extension UIColor {
    
    // MARK: - Methods

    static func initialize(with style: Color) -> UIColor {
        guard let color = UIColor(named: style.rawValue) else {
            fatalError("Color named \(style.rawValue) not found. Make sure you added it in Colors.xcassets.")
        }

        return color
    }
}
