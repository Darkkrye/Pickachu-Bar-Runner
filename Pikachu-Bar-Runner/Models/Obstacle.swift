//
//  Obstacle.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 24/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Cocoa
import SpriteKit

class Obstacle: SKSpriteNode {
    static let identifier = "obstacle"
    static let zIndex: CGFloat = Player.zIndex
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.texture = SKTexture(imageNamed: "obstacle")
        self.initialize()
    }
    
    init() {
        super.init(texture: SKTexture(imageNamed: "obstacle"), color: .clear, size: .zero)
        self.initialize()
    }
}

// MARK: - Extension for setup methods
extension Obstacle {
    func initialize() {
        self.name = Obstacle.identifier
        self.position = .zero
        self.size = CGSize(width: 15, height: 15)
        self.zPosition = Obstacle.zIndex
        
        self.physicsBody = self.createPhysicsBody()
    }
    
    func createPhysicsBody() -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = StaticDataProviders.obstacle
        physicsBody.contactTestBitMask = StaticDataProviders.player
        
        return physicsBody
    }
}
