//
//  Player.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 23/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Cocoa
import SpriteKit

class Player: SKSpriteNode {
    // Static constants
    static let identifier = "player"
    static let zIndex: CGFloat = 10
    static let spriteSize: Double = 18
    static let spriteMultiplication = 18 * 1.2051282051
    static let velocity: CGFloat = 300
    
    static let movement = SKTextureAtlas(named: "pikachu_movements").textureNames.map { SKTexture(imageNamed: $0) }
    
    // Constructors
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.texture = Player.movement.first
        self.initialize()
    }
    
    init() {
        super.init(texture: Player.movement.first, color: .clear, size: .zero)
        self.initialize()
    }
}

// MARK: - Extension for setup methods
extension Player {
    func initialize() {
        self.name = Player.identifier
        self.position = CGPoint(x: 0, y: 0)
        self.size = CGSize(width: Player.spriteMultiplication, height: Player.spriteSize)
        self.zPosition = Player.zIndex
        self.physicsBody = self.createPhysicsBody()
        
        self.run(SKAction.repeatForever(SKAction.animate(with: Player.movement, timePerFrame: 0.1, resize: false, restore: true)), withKey: "player-movement-animation")
    }
    
    func createPhysicsBody() -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(rectangleOf: self.size)
        
        physicsBody.isDynamic = true
        physicsBody.affectedByGravity = true
        physicsBody.allowsRotation = false
        physicsBody.velocity.dx = Player.velocity
        physicsBody.categoryBitMask = StaticDataProviders.player
        physicsBody.collisionBitMask = StaticDataProviders.ground
        physicsBody.contactTestBitMask = StaticDataProviders.obstacle
        
        return physicsBody
    }
}

// MARK: - Extension for personal methods
extension Player {
    func keepVelocity() {
        self.physicsBody?.velocity.dx = Player.velocity
    }
    
    func jump() {
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -Player.spriteMultiplication - 5))
    }
}
