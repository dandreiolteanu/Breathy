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

    /// 1:20, 1:23:43
    var hourMinuteSecondFormatted: String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = self > 3600 ? [.hour, .minute, .second ] : [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]

        return formatter.string(from: self)
    }
}
