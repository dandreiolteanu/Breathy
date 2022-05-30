//
//  TimeInterval+Extensions.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import Foundation

extension TimeInterval {

    // MARK: - Properties

    /// 1 min
    var minutesFormatted: String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.minute]
        formatter.zeroFormattingBehavior = .dropAll

        return formatter.string(from: self)
    }

}
