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
        updateScore()
        addTapRecognizer()
    
    
    }
    
    func addTapRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "selectOrMenuTapped:")
        tapGestureRecognizer.allowedPressTypes = [
            NSNumber(integer: UIPressType.Select.rawValue),
            NSNumber(integer: UIPressType.Menu.rawValue)
        ];
        
        guard let view = self.view else {
            return
        }
        
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func selectOrMenuTapped(tapGestureRecognizer : UITapGestureRecognizer) {
        loadGameScene()
    }
    
    
    func connectOutlets() {
        player1ScoreLabel = childNodeWithName("Player1ScoreLabel") as! SKLabelNode
        player2ScoreLabel = childNodeWithName("Player2ScoreLabel") as! SKLabelNode
        
    }
    
    func updateScore() {
        
        guard let data = userData,
                  player1Score = data[Constants.CommonKeys.player1Score],
                  player2Score = data[Constants.CommonKeys.player2Score]
                  else {
            return
        }
        
        player1ScoreLabel.text = "You: \(player1Score)"
        player2ScoreLabel.text = "Computer: \(player2Score)"
  
        
    }
    
    func loadGameScene() {
        
        guard let scene = SKScene(fileNamed: Constants.Scenes.GameScene) as? GameScene else {
            return
        }
        
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        self.view?.presentScene(scene, transition:reveal)
  
    }
    

}
