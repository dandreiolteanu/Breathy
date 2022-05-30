//
//  ComingSoonCellViewModel.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import Foundation

struct ComingSoonCellViewModel {

    // MARK: - Properties

    let title: String = L10n.BreathingExercisesList.comingSoonTitle
    let subtitle: String = L10n.BreathingExercisesList.comingSoonSubtitle
}

// MARK: - Hashable

extension ComingSoonCellViewModel: Hashable { }
