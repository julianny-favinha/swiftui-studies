//
//  Model.swift
//  UnitConverter
//
//  Created by Julianny Favinha on 05/09/20.
//  Copyright © 2020 Julianny Favinha. All rights reserved.
//

import Foundation

enum Measure: String, CaseIterable {
    case temperature = "Temperature"
    case time = "Time"
}

enum Temperature: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

enum Time: String, CaseIterable {
    case second
    case minute
    case hour
    case day
}
