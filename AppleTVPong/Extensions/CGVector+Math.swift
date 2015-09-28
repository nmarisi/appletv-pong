//
//  CGPoint+VectorMath.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-09-28.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import SpriteKit

func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}

func - (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

func * (point: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: point.dx * scalar, dy: point.dy * scalar)
}

func / (point: CGVector, scalar: CGFloat) -> CGVector {
    return CGVector(dx: point.dx / scalar, dy: point.dy / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGVector {
    func length() -> CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
    
    func normalized() -> CGVector {
        return self / length()
    }
}