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
    
    override func didMoveToView(view: SKView) {
        
        initialTouch = view.frame.origin
        player1 = self.childNodeWithName("Player1") as! SKSpriteNode
        player2 = self.childNodeWithName("Player2") as! SKSpriteNode
        ball = self.childNodeWithName("Ball") as! SKSpriteNode

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
        
        if touchLocation.y < initialTouch.y { // Going down
            let moveAction = SKAction.moveBy(CGVectorMake(0, -20), duration: 0.5)
            player1.runAction(moveAction)
            player2.runAction(moveAction)
        } else { // Going up
            //let moveAction = SKAction.moveToY(touchLocation.y, duration: 0.5)
            let moveAction = SKAction.moveBy(CGVectorMake(0, +20), duration: 0.5)
            player1.runAction(moveAction)
            player2.runAction(moveAction)
        }
        
        print(touchLocation)
        
    
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
       
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        
        
    }
}
