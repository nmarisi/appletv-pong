//
//  GameScene.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-09-27.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player1: SKSpriteNode!
    var player2: SKSpriteNode!
    var ball: SKSpriteNode!
    var initialTouch:CGPoint!
    
    let boundaryWith:CGFloat = 40
    
    override func didMoveToView(view: SKView) {
        
        initialTouch = view.frame.origin
        player1 = self.childNodeWithName("Player1") as! SKSpriteNode
        player2 = self.childNodeWithName("Player2") as! SKSpriteNode
        ball = self.childNodeWithName("Ball") as! SKSpriteNode
        
        //ball.physicsBody!.applyImpulse(CGVectorMake(1000, -10))
        ball.physicsBody?.velocity = CGVectorMake(500, 250)
        ball.physicsBody?.usesPreciseCollisionDetection = true
        
        
        let borderBody = SKPhysicsBody(edgeLoopFromRect: frame)
        borderBody.usesPreciseCollisionDetection = true
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        /* Called when a touch begins */
        
        guard let touch = touches.first else {
            return
        }
        
        
        
        initialTouch = touch.locationInNode(self)
   
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.locationInNode(self)
        let previousLocation = touch.previousLocationInNode(self)
        
        let player1Y = player1.position.y + (touchLocation.y - previousLocation.y)
        movePlayer(player1, yLocation: player1Y)
        

        
    
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
       
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        
        
    }
    
    //MARK: Convenience functions
    func movePlayer(player: SKSpriteNode, yLocation: CGFloat) {
       
        // Avoid moving the player outside of the screen
        if yLocation > (view!.frame.size.width / 2) + (player1.size.width  / 2) ||
            yLocation < boundaryWith + (player1.size.width / 2) {
            return
        }
        print(yLocation)

        player1.position = CGPointMake(player.position.x, yLocation)
        
    }
    
}
