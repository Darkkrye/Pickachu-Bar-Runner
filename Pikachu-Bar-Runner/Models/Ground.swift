//
//  Ground.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 23/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Cocoa
import SpriteKit

class Ground: SKSpriteNode {
    static let identifier = "ground"
    static let zIndex: CGFloat = 200
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    init() {
        super.init(texture: nil, color: .clear, size: .zero)
        self.initialize()
    }
}

// MARK: - Extension for setup methods
extension Ground {
    func initialize() {
        self.name = Ground.identifier
        self.size = CGSize(width: 1920, height: 0)
        self.position = .zero
        self.zPosition = Ground.zIndex
        
        self.physicsBody = self.createPhysicsBody()
    }
    
    func createPhysicsBody() -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        physicsBody.categoryBitMask = StaticDataProviders.ground
        physicsBody.fieldBitMask = StaticDataProviders.ground
        physicsBody.collisionBitMask = StaticDataProviders.player
        physicsBody.isDynamic = false
        
        return physicsBody
    }
}
