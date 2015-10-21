//
//  Constants.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-10-03.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import SpriteKit


public struct Constants {

    static let boundaryHeight:CGFloat = 60
    static let winningScore = 10
    
    struct PhysicsCategory {
        static let None       : UInt32 = 0
        static let All        : UInt32 = UInt32.max
        static let Player1    : UInt32 = 1 << 0// 1
        static let Player2    : UInt32 = 1 << 1// 2
        static let Ball       : UInt32 = 1 << 2// 4
        static let Bar        : UInt32 = 1 << 3// 8
        static let LeftGoal   : UInt32 = 1 << 4// 16
        static let RightGoal  : UInt32 = 1 << 5// 16
        static let Goals      : UInt32 = LeftGoal | RightGoal // Both goals
    }
    
    struct CommonKeys {
        static let player1Score = "player1Score"
        static let player2Score = "player2Score"
    }
    
    struct Scenes {
        static let GameScene = "GameScene"
        static let GameOverScene = "GameOverScene"
    }
}