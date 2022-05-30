//
//  SnapKit+Extensions.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import SnapKit
import UIKit

extension ConstraintMakerEditable {

    @discardableResult
    func offsetBy(_ constant: CGFloat) -> ConstraintMakerEditable {
        offset(constant)
    }

    @discardableResult
    func insetBy(_ constant: CGFloat) -> ConstraintMakerEditable {
        inset(constant)
    }
}
