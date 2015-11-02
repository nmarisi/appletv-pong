//
//  GameScene.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-09-27.
//  Copyright (c) 2015 TechBrewers. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player1: SKSpriteNode!
    var player2: SKSpriteNode!
    var ball: SKSpriteNode!
    var initialTouch:CGPoint!
    var player1Score = 0
    var player2Score = 0
    var player1ScoreLabel: SKLabelNode!
    var player2ScoreLabel: SKLabelNode!
    
    let bipAudioPlayer = AVAudioPlayer.audioPlayerForMP3("bip")
    let goalAudioPlayer = AVAudioPlayer.audioPlayerForMP3("goal")

    let boundaryHeight:CGFloat = 60
   
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        connectOutlets()
        createSceneContent(view)
        createBall()
        
        //addGestureRecogniser()
    }
    
    func connectOutlets() {
        player1 = self.childNodeWithName("Player1") as! SKSpriteNode
        player2 = self.childNodeWithName("Player2") as! SKSpriteNode
        player1ScoreLabel = self.childNodeWithName("Player1Score") as! SKLabelNode
        player2ScoreLabel = self.childNodeWithName("Player2Score") as! SKLabelNode
    }
    
    func createBall() {
        ball = Ball(velocity: CGVectorMake(1250, 450))
        ball.position = CGPointMake(frame.width / 2 + 100, frame.height / 2)
        ball.zPosition = 10
        addChild(ball)
    }
    
    func addGestureRecogniser() {
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "userPanned:")
        view!.addGestureRecognizer(panGestureRecognizer)
    }
    
    /*
    
    func userPanned(panGestureRecognizer : UIPanGestureRecognizer) {
        
        let translation = panGestureRecognizer.translationInView(self.view)
        let player1Y = player1.position.y - (translation.y * 0.5)
        
        print("translation: \(translation)")
        
        //if (panGestureRecognizer.state == .Changed) {
            player1.removeAllActions()
            let moveAction =  SKAction.moveTo(CGPointMake(player1.position.x, player1Y), duration: 0.1) // Double(time))
            moveAction.timingMode = .EaseOut
            player1.runAction(moveAction)
        //}
    }
    */
   
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
                
                
                // This change in impulse is used to stop the ball from getting 'glued' to the boarders.
                let strength = 1.0 * (ball.position.x < frame.width / 2 ? 1 : -1)
                let body = ball.physicsBody!
                body.applyImpulse(CGVector(dx: strength, dy: 0))
                
        }
        
        if ((firstBody.categoryBitMask & Constants.PhysicsCategory.Players != 0) &&
            (secondBody.categoryBitMask & Constants.PhysicsCategory.Ball != 0)) {
                
                bipAudioPlayer?.play()
        }

        
        
        if ((firstBody.categoryBitMask & Constants.PhysicsCategory.Ball != 0) &&
            (secondBody.categoryBitMask & Constants.PhysicsCategory.RightGoal != 0)) {
                
                player2Score += 1
                player2ScoreLabel.text = "\(player2Score)"
                self.restartGame()
                
        } else if ((firstBody.categoryBitMask & Constants.PhysicsCategory.Ball != 0) &&
            (secondBody.categoryBitMask & Constants.PhysicsCategory.LeftGoal != 0)) {
                
                player1Score += 1
                player1ScoreLabel.text = "\(player1Score)"
                self.restartGame()
        }
        checkForWin()
        
    }
    
    
    func checkForWin() {
        
  
        if player1Score >= Constants.winningScore  {
            loadWinningScene()
            
            
        } else if player2Score >= Constants.winningScore {
            loadWinningScene()
            
        }
    }
    
    
    func loadWinningScene() {
        
        guard let scene = SKScene(fileNamed: Constants.Scenes.GameOverScene) as? GameOverScene else {
            return
        }
        
        scene.userData = [
            Constants.CommonKeys.player1Score: player1Score,
            Constants.CommonKeys.player2Score: player2Score
        ]
        
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        self.view?.presentScene(scene, transition:reveal)
        
    }
    
    
    func restartGame() {
        
        goalAudioPlayer?.play()
        self.removeChildrenInArray([ball])
        self.removeAllActions()
        self.createBall()
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
        
        let moveLocation = CGPointMake(player.position.x, yLocation)
        
        if animated {
            let moveAction = SKAction.moveTo(moveLocation, duration: 0.25)
            player.runAction(moveAction)
        } else {
            
            /*
            
            let speed:CGFloat = 5000
            let time = moveLocation.y / speed
            player.removeAllActions()
            let moveAction =  SKAction.moveTo(moveLocation, duration: 0.1) // Double(time))
            moveAction.timingMode = .EaseOut
            player.runAction(moveAction)
*/
            
            player.position = moveLocation
        }
    }
}
