//
//  GameOverScene.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-10-18.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var player1ScoreLabel: SKLabelNode!
    var player2ScoreLabel: SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        connectOutlets()
    
    }
    
    func connectOutlets() {
        player1ScoreLabel = childNodeWithName("Player1ScoreLabel") as! SKLabelNode
        player2ScoreLabel = childNodeWithName("Player2ScoreLabel") as! SKLabelNode
        
    }
    
    func updateScore() {
        
    }
    

}
