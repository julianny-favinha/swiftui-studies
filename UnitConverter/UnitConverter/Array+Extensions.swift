//
//  Array+Extensions.swift
//  UnitConverter
//
//  Created by Julianny Favinha on 05/09/20.
//  Copyright © 2020 Julianny Favinha. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
