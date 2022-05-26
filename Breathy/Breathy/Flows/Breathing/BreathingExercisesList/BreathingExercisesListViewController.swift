//
//  BreathingExercisesListViewController.swift
//  BreathingExercises
//
//  Created by Andrei Olteanu on 26.05.2022.
//

import UIKit
import SnapKit

final class BreathingExercisesListViewController: UIViewController {
    
    // MARK: - Private properties

    private let viewModel: BreathingExercisesListViewModel

    private let tableView = UITableView()

    // MARK: - Init

    init(viewModel: BreathingExercisesListViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
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
    }

    private func setupView() {
        navigationItem.title = "Breathy"

        view.backgroundColor = .primaryBackground

        tableView.backgroundColor = view.backgroundColor
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupBindings() {
        
    }
}
