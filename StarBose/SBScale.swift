//
//  SBScale.swift
//  StarBose
//
//  Created by MrSmall on 2015/07/23.
//  Copyright © 2015年 MrSmall. All rights reserved.
//

import Foundation
import SpriteKit

// width size rate
let SIZE_ACPECT_RATE :CGFloat = 0.9

class SBScale {

    var size :CGSize
    var diffX :CGFloat
    var diffY :CGFloat
    var divSizeX :CGFloat
    var divSizeY :CGFloat

    // initialize
    init(scene :GameScene) {
        // adjust size
        let w = scene.size.width * SIZE_ACPECT_RATE
        diffX = (scene.size.width - w) / 2.0
        diffY = (scene.size.height - w) / 2.0
        size = CGSize(width: w, height: w)
        
        // calc divid size
        divSizeX = size.width / CGFloat(WIDTH)
        divSizeY = size.height / CGFloat(HEIGHT)
    }
    
    // convert absolute position to index
    func convert(x :CGFloat, y :CGFloat) -> (ix :Int, iy :Int) {
        if x < diffX || (size.width + diffX) < x {
            return (-1, -1)
        }
        if y < diffY || (size.height + diffY) < y {
            return (-1, -1)
        }
        // convert Absolute position
        let dex = Int(x - diffX) / Int(divSizeX)
        let dey = Int(y - diffY) / Int(divSizeY)
        return (dex, dey)
    }
}