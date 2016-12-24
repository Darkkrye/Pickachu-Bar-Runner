//
//  Window.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 22/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Cocoa

class Window: NSWindow {
    override func keyDown(with event: NSEvent) {
        if event.keyCode == 49 {
            NotificationCenter.default.post(name: StaticDataProviders.jumpNotification, object: nil)
        }
    }
}
