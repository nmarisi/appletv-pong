//
//  GoalSprite.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-10-03.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import SpriteKit

enum GoalType {
    case Left
    case Right
}

class GoalSprite: SKSpriteNode {
    
    
    convenience init(goalType: GoalType, screenSize:CGSize) {
        self.init()
        
        self.size = CGSizeMake(10, screenSize.height)
        //self.anchorPoint = CGPointMake(0, 0)
        //self.color = UIColor.redColor()
        
        let topLeft = CGPointMake(0, screenSize.height - Constants.boundaryHeight)
        let bottomLeft = CGPointMake(0, Constants.boundaryHeight)
        let topRight = CGPointMake(screenSize.width, screenSize.height - Constants.boundaryHeight)
        let bottomRight = CGPointMake(screenSize.width, Constants.boundaryHeight)
        
        if goalType == .Left {
            self.physicsBody = SKPhysicsBody(edgeFromPoint: bottomLeft , toPoint: topLeft)
            self.position = CGPointMake(0, screenSize.height / 2)
            self.physicsBody?.categoryBitMask = Constants.PhysicsCategory.LeftGoal
        } else { //.Right
            self.physicsBody = SKPhysicsBody(edgeFromPoint: bottomRight, toPoint: topRight)
            self.position = CGPointMake(bottomRight.x, screenSize.height / 2)
            self.physicsBody?.categoryBitMask = Constants.PhysicsCategory.RightGoal
        }
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.zPosition = 100
        self.physicsBody?.contactTestBitMask = Constants.PhysicsCategory.Ball
        self.physicsBody?.collisionBitMask = Constants.PhysicsCategory.Ball
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.dynamic = false
    }

}
