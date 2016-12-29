//
//  Diglett.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 29/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Cocoa
import SpriteKit

class Diglett: SKSpriteNode {
    static let identifier = "diglett"
    static let zIndex: CGFloat = Player.zIndex
    
    static let movement = SKTextureAtlas(named: "diglett_movements").textureNames.map { SKTexture(imageNamed: $0) }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.texture = Diglett.movement.first
        self.initialize()
    }
    
    init() {
        super.init(texture: Diglett.movement.first, color: .clear, size: .zero)
        self.initialize()
    }
}

// MARK: - Extension for setup methods
extension Diglett {
    func initialize() {
        self.name = Diglett.identifier
        self.position = .zero
        self.size = CGSize(width: 15, height: 15)
        self.zPosition = Diglett.zIndex
        self.physicsBody = self.createPhysicsBody()
        
        self.run(SKAction.repeatForever(SKAction.animate(with: Diglett.movement, timePerFrame: 0.15, resize: false, restore: true)), withKey: "diglett-movement-animation")
        
        self.physicsBody = self.createPhysicsBody()
    }
    
    func createPhysicsBody() -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 8, height: 4))
        
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.isDynamic = false
        physicsBody.categoryBitMask = StaticDataProviders.obstacle
        physicsBody.contactTestBitMask = StaticDataProviders.player
        
        return physicsBody
    }
}
