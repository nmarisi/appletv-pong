//
//  GameScene.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-09-27.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player1: SKSpriteNode!
    var player2: SKSpriteNode!
    var ball: SKSpriteNode!
    var initialTouch:CGPoint!
    
    
    let boundaryHeight:CGFloat = 60
   
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        connectOutlets()
        createSceneContent(view)
        createBall()
    }
    
    func connectOutlets() {
        player1 = self.childNodeWithName("Player1") as! SKSpriteNode
        player2 = self.childNodeWithName("Player2") as! SKSpriteNode
    }
    
    func createBall() {
        ball = Ball(velocity: CGVectorMake(1250, 450))
        ball.zPosition = 10
        addChild(ball)
    }
    
    func createSceneContent(view: SKView) {
        
        
        initialTouch = view.frame.origin

        let leftGoal = GoalSprite(goalType: .Left, screenSize: frame.size)
        let rightGoal = GoalSprite(goalType: .Right, screenSize: frame.size)
        
       
        addChild(leftGoal)
        addChild(rightGoal)
       
        
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
        movePlayer(player1, yLocation: player1Y, animated: false)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
       
        
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & Constants.PhysicsCategory.Ball != 0) &&
            (secondBody.categoryBitMask & Constants.PhysicsCategory.Bar != 0)) {
                
                //ball.physicsBody?.applyImpulse(CGVectorMake(150, 50))
                
                let strength = 1.0 * (ball.position.x < frame.width / 2 ? 1 : -1)
                let body = ball.physicsBody!
                body.applyImpulse(CGVector(dx: strength, dy: 0))
                
                
                guard let ballBody = ball.physicsBody else {
                    return
                }
        } else {
            
        }
       if ((firstBody.categoryBitMask & Constants.PhysicsCategory.Ball != 0) &&
            (secondBody.categoryBitMask & Constants.PhysicsCategory.Goal != 0)) {
                
                self.restartGame()
        }
        
        
    
    }
    
    
    func restartGame() {
        
        self.removeAllChildren()
        self.removeAllActions()
        
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
                return
            }
        
        view?.presentScene(scene, transition: SKTransition.fadeWithDuration(0.5))
        
        return
        
        if let view = self.view {
            self.createSceneContent(view)
        }
    }
    
    
    
    
    func determinant(a a: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat {
        
        return a * d - b * c
    }
    
    // Note: Four our purposes we don't care if lines are parallel or do not intersec
    func intersectionSeg1Seg2(p1 p1: CGPoint, p2: CGPoint, p3: CGPoint, p4: CGPoint) -> CGPoint? {

        let d1 = determinant(a: p1.x, b: p1.y, c: p2.x, d: p2.y)
        let d2 = determinant(a: p1.x, b: 1, c: p2.x, d: 1)
        let d3 = determinant(a: p3.x, b: p3.y, c: p4.x, d: p4.y)
        let d4 = determinant(a: p3.x, b: 1, c: p4.x, d: 1)

        let upperFinalDet =  determinant(a: d1, b: d2, c:d3, d: d4)
        
        
        let d5 = determinant(a: p1.x, b: 1, c: p2.x, d: 1)
        let d6 = determinant(a: p1.y, b: 1, c: p2.y, d: 1)
        let d7 = determinant(a: p3.x, b: 1, c: p4.x, d: 1)
        let d8 = determinant(a: p3.y, b: 1, c: p4.y, d: 1)
        
        let lowerFinalDet = determinant(a: d5, b: d6, c: d7, d: d8)
        
        // §finally calculate the X intersection point
        let xIntersec = upperFinalDet / lowerFinalDet
        
        /* do a similar thing for the Y coord */
        let dd1 = determinant(a: p1.x, b: p1.y, c: p2.x, d: p2.y)
        let dd2 = determinant(a: p1.y, b: 1, c: p2.y, d: 1) 
        let dd3 = determinant(a: p3.x, b: p3.y, c: p4.x, d: p4.y) 
        let dd4 = determinant(a: p3.y, b: 1, c: p4.y, d: 1) 
        
        let upperFinalDeterminant = determinant(a: dd1, b: dd2, c: dd3, d: dd4) 
        
        let dd5 = determinant(a: p1.x, b: 1, c: p2.x, d: 1) 
        let dd6 = determinant(a: p1.y, b: 1, c: p2.y, d: 1) 
        let dd7 = determinant(a: p3.x, b: 1, c: p4.x, d: 1) 
        let dd8 = determinant(a: p3.y, b: 1, c: p4.y, d: 1) 
        
        let lowerFinalDeterminant = determinant(a: dd5, b: dd6, c: dd7, d: dd8)
        
        // calc final Y point
        let yIntersec = upperFinalDeterminant / lowerFinalDeterminant

        return CGPointMake(xIntersec, yIntersec)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
       
        guard let ballBody = ball.physicsBody else {
            return
        }
       
        let direction = ballBody.velocity.normalized()
        let ballDestination = direction * 1000

        let p1 = ball.position
        let p2 = ballDestination + ball.position
        // Y line intersection is in front of player2
        let p3 = CGPointMake(frame.size.width - player2.frame.size.width, frame.size.height - boundaryHeight )
        let p4 = CGPointMake(frame.size.width - player2.frame.size.width, 0 + boundaryHeight)
        
        if let intersection = intersectionSeg1Seg2(p1: p1, p2: p2, p3: p3, p4: p4) {
            
            movePlayer(player2, yLocation: abs(intersection.y), animated: true)
            
         } else {
            //infinite, so no intersection.
        }
    }
    
    //MARK: Convenience functions
    func movePlayer(player: SKSpriteNode, yLocation: CGFloat, animated: Bool) {

        if yLocation > view!.frame.size.height - boundaryHeight  ||
            yLocation < boundaryHeight {
                return
        }
        
        //print("yLocation: \(yLocation)")

        let moveLocation = CGPointMake(player.position.x, yLocation)
        
        if animated {
            let moveAction = SKAction.moveTo(moveLocation, duration: 0.1)
            player.runAction(moveAction)
        } else {
            player.position = moveLocation
        }
        
        
    }
    
}
