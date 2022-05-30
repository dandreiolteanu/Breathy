//
//  GreetingCellViewModel.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import Foundation

struct GreetingCellViewModel {

    // MARK: - Properties

    let title: String
    let subtitle: String

    init(userName: String) {
        self.title = Self.makeTitle(with: userName)
        self.subtitle = L10n.BreathingExercisesList.subtitle
    }

    // MARK: - Private Static Methods

    private static func makeTitle(with userName: String) -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 6..<12 :
            return L10n.BreathingExercisesList.morningTitle(userName)
        case 12..<18 :
            return L10n.BreathingExercisesList.afternoonTitle(userName)
        default:
            return L10n.BreathingExercisesList.eveningTitle(userName)
        }
    }
}

// MARK: - Hashable

extension GreetingCellViewModel: Hashable { }
