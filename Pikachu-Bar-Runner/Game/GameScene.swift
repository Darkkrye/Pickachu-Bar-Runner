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
    var backgroundRepeater: BackgroundRepeater!
    var ground: Ground!
    var player: Player!
    
    var obstacleTime: CFTimeInterval            = 1
    var obstaclePreviousTime: CFTimeInterval    = 0
    var obstacleTimeCount: CFTimeInterval       = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // Activate debug view
        self.debug(view: view)
        
        // Set delegates
        self.physicsWorld.contactDelegate = self
        
        // Add NotificationCenter observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.jump), name: StaticDataProviders.jumpNotification, object: nil)
        
        // Set background
        self.scaleMode = .resizeFill
        self.backgroundRepeater = BackgroundRepeater(root: self)
        
        // Create items
        self.ground = Ground()
        self.player = Player()
        let camera = SKCameraNode()
        camera.position = CGPoint(x: self.player.position.x, y: 15.5)
        self.camera = camera
        
        // Add items to self
        self.addChild(self.ground)
        self.addChild(self.player)
        self.addChild(camera)
        
        // Set pause by default
        self.isPaused = true
        self.alpha = 0.3
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        self.obstacleTimeCount += currentTime - self.obstaclePreviousTime
        
        if self.obstacleTimeCount > self.obstacleTime {
            self.obstacleTime = Double.random(min: 0.5, max: 2)
            self.createObstacle()
            self.obstacleTimeCount = 0
            
            NotificationCenter.default.post(name: StaticDataProviders.scoreNotification, object: nil)
        }
        
        self.obstaclePreviousTime = currentTime
        self.backgroundRepeater.calculateNext(position: self.player.position.x)
        
        self.enumerateChildNodes(withName: Obstacle.identifier) { node, _ in
            if node.position.x < self.player.position.x - 2000 {
                node.removeFromParent()
            }
        }
    }
    
    override func didFinishUpdate() {
        super.didFinishUpdate()
        
        self.player.keepVelocity()
        
        self.ground.position.x = self.player.position.x
        self.camera?.position.x = self.player.position.x
    }
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
    func didBegin(_ contact: SKPhysicsContact) {
        self.isPaused = true
        self.alpha = 0.3
        
        NotificationCenter.default.post(name: StaticDataProviders.replayButtonNotification, object: nil)
    }
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
            self.player.jump()
        }
    }
}

// MARK: - Extension for create methods
extension GameScene {
    func createObstacle() {
        let obstacle = Obstacle()
        obstacle.position.x = self.player.position.x + 1000
        obstacle.position.y = 8
        
        self.addChild(obstacle)
    }
    
    func createDiglett() {
        
    }
    
    func createDugtrio() {
        
    }
}

// MARK: - Extension for personal methods
extension GameScene {
    
}
