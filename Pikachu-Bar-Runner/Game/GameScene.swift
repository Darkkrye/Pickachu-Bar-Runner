//
//  GameScene.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 22/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Cocoa
import GameplayKit

class GameScene: SKScene {
    // MARK: - Variables
//    var backgroundRepeater: BackgroundRepeater!
//    var ground: Ground!
//    var player: Player!
    
    var obstacleTime: CFTimeInterval            = 1.0
    var obstaclePreviousTime: CFTimeInterval    = 0
    var obstacleTimeCount: CFTimeInterval       = 0
}

// MARK: - Extension for default methods
extension GameScene {
    func debug(view: SKView) {
        let debug           = true
        view.showsPhysics   = debug
        view.showsFPS       = debug
        view.showsNodeCount = debug
        view.showsFields    = debug
    }
    
    
}

// MARK: - Extension for SKPhysicsContact Delegate
extension GameScene: SKPhysicsContactDelegate {
    
}

// MARK: - Extension for NotificationCenter methods
extension GameScene {
    public func play() {
        self.isPaused = false
        self.alpha = 1
        
        NotificationCenter.default.post(name: StaticDataProviders.pauseButtonNotification, object: nil)
    }
    
    public func pause() {
        self.isPaused = true
        self.alpha = 0.5
        
        NotificationCenter.default.post(name: StaticDataProviders.playButtonNotification, object: nil)
    }
    
    public func jump() {
        if !self.isPaused {
//            self.player.jump()
        }
    }
}

// MARK: - Extension for create methods
extension GameScene {
    
}

// MARK: - Extension for personal methods
extension GameScene {
    
}
