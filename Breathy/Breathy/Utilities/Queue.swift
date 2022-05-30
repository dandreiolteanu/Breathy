//
//  Queue.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import Foundation

final class Queue<T> {

    // MARK: - Private Properties

    private var elements: [T] = []

    // MARK: - Public Properties

    var isEmpty: Bool {
        return elements.isEmpty
    }

    var size: Int {
        return elements.count
    }

    // MARK: - Public Methods
    
    func enqueue(element: T) {
        elements.append(element)
    }

    @discardableResult
    func dequeue() -> T? {
        guard !elements.isEmpty else { return nil }
        let elem = elements.removeFirst()
        return elem
    }

    func reset() {
        elements.removeAll()
    }
}
