//
//  SBManager.swift
//  StarBose
//
//  Created by MrSmall on 2015/07/03.
//  Copyright (c) 2015年 MrSmall. All rights reserved.
//

import Foundation
import SpriteKit

// declare turn
let TURN_FIRST = 0
let TURN_LAST = 1

// declare Squares : 3×3
let WIDTH :Int = 3
let HEIGHT :Int = 3

// StarBose game management class.
class SBManager {
    
    var turn :Int!
    var drawer :SBDrawer!
    var state :SBState!
    
    // initalize
    init(scene :GameScene) {
        turn = TURN_FIRST
        drawer = SBDrawer(scene: scene)
        state = SBState()
    }
    
    // on touch
    func onTouch(point :CGPoint) {

        if turn == TURN_FIRST {
            drawer.addPiece(point.x, y: point.y, p: Piece.STAR)
            turn = TURN_LAST
            
        } else {
            drawer.addPiece(point.x, y: point.y, p: Piece.BOSE)
            turn = TURN_FIRST
            
        }
    }
}