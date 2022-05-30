//
//  Reusable.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import UIKit

protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

extension Reusable {

  static var reuseIdentifier: String {
    String(describing: self)
  }
}
