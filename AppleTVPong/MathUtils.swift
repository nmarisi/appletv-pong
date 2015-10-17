//
//  MathUtils.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-10-17.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import SpriteKit

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