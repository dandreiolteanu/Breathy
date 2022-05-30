//
//  BreathingExercisesListViewController.swift
//  BreathingExercises
//
//  Created by Andrei Olteanu on 26.05.2022.
//

import Combine
import UIKit
import SnapKit

final class BreathingExercisesListViewController: BaseViewController {
    
    // MARK: - Private properties

    private let viewModel: BreathingExercisesListViewModel

    private let tableView = UITableView()

    private lazy var dataSource = makeDataSource()
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: BreathingExercisesListViewModel) {
        self.viewModel = viewModel

        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        setupBindings()

        viewModel.inputs.viewLoaded()
    }

    private func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: true)

        tableView.register(cellType: GreetingTableViewCell.self)
        tableView.register(cellType: BreathingExercisesListTableViewCell.self)
        tableView.register(cellType: ComingSoonTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = view.backgroundColor
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupBindings() {
        viewModel.outputs.shouldReloadSubject
            .sink { [weak self] in
                guard let self = self else { return }

                self.dataSource.apply(self.viewModel.outputs.dataSourceSnapshot, animatingDifferences: true)
            }
            .store(in: &subscriptions)
    }
}

// MARK: - UITableViewDelegate

extension BreathingExercisesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        viewModel.inputs.didSelectRow(at: indexPath)
    }
}

extension BreathingExercisesListViewController {

    private func makeDataSource() -> UITableViewDiffableDataSource<BreathingExercisesListViewModelImpl.Section, BreathingExercisesListViewModelImpl.Cell> {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .greeting(let cellViewModel):
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GreetingTableViewCell.self)
                cell.viewModel = cellViewModel
                return cell
            case .exercise(let cellViewModel):
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BreathingExercisesListTableViewCell.self)
                cell.viewModel = cellViewModel
                return cell
            case .comingSoon(let cellViewModel):
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ComingSoonTableViewCell.self)
                cell.viewModel = cellViewModel
                return cell
            }
        }
    }
}
