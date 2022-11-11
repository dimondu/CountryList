//
//  Box.swift
//  CountryList
//
//  Created by Дмитрий Дуров on 11.11.2022.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: Listener?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self .listener = listener
        listener(value)
    }
}
