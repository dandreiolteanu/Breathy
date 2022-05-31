//
//  BreathingExercisesListViewModel.swift
//  BreathingExercises
//
//  Created by Andrei Olteanu on 26.05.2022.
//

import Foundation
import Combine
import UIKit.UIDiffableDataSource

protocol BreathingExercisesListFlowDelegate: AnyObject {
    func didSelectBreathingExerciseInfo(on viewModel: BreathingExercisesListViewModel, breathingExerciseInfo: BreathingExerciseInfo)
}

protocol BreathingExercisesListViewModelInputs {
    func viewLoaded()
    func didSelectRow(at indexPath: IndexPath)
}

protocol BreathingExercisesListViewModelOutputs {
    var dataSourceSnapshot: BreathingExercisesListViewModelImpl.DataSourceType { get }
    var shouldReloadSubject: AnyPublisher<Void, Never> { get }
}

protocol BreathingExercisesListViewModel {
    var inputs: BreathingExercisesListViewModelInputs { get }
    var outputs: BreathingExercisesListViewModelOutputs { get }
}

final class BreathingExercisesListViewModelImpl: BreathingExercisesListViewModel, BreathingExercisesListViewModelInputs, BreathingExercisesListViewModelOutputs {

    // MARK: - Section

    enum Section: String, Hashable {
        case greeting, exercises, comingSoon
    }

    enum Cell: Hashable {
        case greeting(GreetingCellViewModel)
        case exercise(BreathingExercisesListCellViewModel)
        case comingSoon(ComingSoonCellViewModel)
    }

    // MARK: - DataSourceType

    typealias DataSourceType = NSDiffableDataSourceSnapshot<Section, Cell>

    // MARK: - FlowDelegate

    weak var flowDelegate: BreathingExercisesListFlowDelegate?

    // MARK: - Public Properties

    var inputs: BreathingExercisesListViewModelInputs { self }
    var outputs: BreathingExercisesListViewModelOutputs { self }

    var dataSourceSnapshot = DataSourceType()

    var shouldReloadSubject: AnyPublisher<Void, Never> {
        _shouldReloadSubject.eraseToAnyPublisher()
    }

    // MARK: - Private Properties

    private let _shouldReloadSubject = PassthroughSubject<Void, Never>()
    private let breathingExercises: [BreathingExerciseInfo]
    
    // MARK: - Init
    
    init(breathingExercisesService: BreathingExercisesService) {
        self.breathingExercises = breathingExercisesService.exercises
    }

    // MARK: - Public Methods

    func viewLoaded() {
        dataSourceSnapshot.appendSections([.greeting])
        dataSourceSnapshot.appendItems([.greeting(GreetingCellViewModel(userName: "Andrei"))],
                                       toSection: .greeting)

        dataSourceSnapshot.appendSections([.exercises])
        dataSourceSnapshot.appendItems(breathingExercises.map { .exercise(BreathingExercisesListCellViewModel(breathingExerciseInfo: $0)) },
                                       toSection: .exercises)

        dataSourceSnapshot.appendSections([.comingSoon])
        dataSourceSnapshot.appendItems([.comingSoon(ComingSoonCellViewModel())],
                                       toSection: .comingSoon)

        _shouldReloadSubject.send(())
    }

    func didSelectRow(at indexPath: IndexPath) {
        switch dataSourceSnapshot.sectionIdentifiers[indexPath.section] {
        case .exercises:
            flowDelegate?.didSelectBreathingExerciseInfo(on: self, breathingExerciseInfo: breathingExercises[indexPath.row])
        case .greeting, .comingSoon:
            break
        }
    }
}
