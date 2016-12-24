//
//  BackgroundRepeater.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 23/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Foundation
import SpriteKit

class BackgroundRepeater {
    // Constants
    let root: SKNode
    let backgroundWidth = 1920
    let backgroundHeight = 60
    let max = 3
    
    // Variables
    var items = [SKSpriteNode]()
    var currentIndex = 1
    
    init(root: SKNode) {
        self.root = root
        
        for i in stride(from: 0, to: self.max, by: 1) {
            let background = self.item(for: i)
            self.root.addChild(background)
            self.items.append(background)
        }
    }
}

// MARK: - Extension for personal methods
extension BackgroundRepeater {
    func calculateNext(position: CGFloat) {
        let position = Int(position) / self.backgroundWidth
        
        if position == self.currentIndex {
            self.next()
        }
    }
    
    func next() {
        self.currentIndex.increment()
        
        self.items.first?.removeFromParent()
        self.items.removeFirst()
        
        let background = self.item(for: self.currentIndex)
        self.root.addChild(background)
        self.items.append(background)
    }
    
    func item(for index: Int) -> SKSpriteNode {
        let positionX = CGFloat(index * self.backgroundWidth)
        let background = SKSpriteNode(imageNamed: "background")
        
        background.size = CGSize(width: self.backgroundWidth, height: self.backgroundHeight)
        background.position.x = positionX
        background.zPosition = 1
        
        return background
    }
}
