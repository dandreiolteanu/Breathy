//
//  View+Extensions.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import SwiftUI
import UIKit

extension View {

    // MARK: - Properties
    
    var asUIViewController: UIViewController {
        UIHostingController(rootView: self)
    }
}
