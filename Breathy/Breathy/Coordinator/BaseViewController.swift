//
//  BaseViewController.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: Asset.imgMainBackground.image)
        imageView.backgroundColor = .primaryBackground
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
