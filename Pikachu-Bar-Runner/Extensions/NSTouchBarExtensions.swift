//
//  NSTouchBarExtensions.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 22/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Cocoa
import Foundation

public extension NSTouchBarCustomizationIdentifier {
    static let customTouchBar = NSTouchBarCustomizationIdentifier("fr.pierreboudon.touchbar.customTouchBar")
}

public extension NSTouchBarItemIdentifier {
    static let customView = NSTouchBarItemIdentifier("fr.pierreboudon.touchbar.items.customView")
    static let playButton = NSTouchBarItemIdentifier("fr.pierreboudon.touchbar.items.playButton")
    static let label = NSTouchBarItemIdentifier("fr.pierreboudon.touchbar.items.label")
    static let scoreLabel = NSTouchBarItemIdentifier("fr.pierreboudon.touchbar.items.scoreLabel")
}
