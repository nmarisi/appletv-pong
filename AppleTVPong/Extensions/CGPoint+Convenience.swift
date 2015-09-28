//
//  CGPoint+Convenience.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-09-28.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import SpriteKit

extension CGPoint {
    static func infinite() -> CGPoint {
        return CGPointMake(CGFloat(CFloat.infinity), CGFloat(CGFloat.infinity))
    }
}
