//
//  Ball.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-10-16.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import SpriteKit

class Ball: SKSpriteNode {
    
    convenience init(velocity: CGVector) {
        self.init(imageNamed: "40Dot")
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.friction = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.velocity = velocity 
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Constants.PhysicsCategory.Ball
        self.physicsBody?.collisionBitMask = Constants.PhysicsCategory.Bar | Constants.PhysicsCategory.Player2
        self.physicsBody?.contactTestBitMask = Constants.PhysicsCategory.Bar
    }
 }


