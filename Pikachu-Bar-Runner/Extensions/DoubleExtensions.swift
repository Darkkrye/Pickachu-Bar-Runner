//
//  DoubleExtensions.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 23/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Foundation

extension Double {
    static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}
