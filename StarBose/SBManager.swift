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
    
    var scale :SBScale
    var drawer :SBDrawer!
    var state :SBState!

    // initalize
    init(scene :GameScene) {
        turn = TURN_FIRST
        state = SBState()
        scale = SBScale(scene: scene)
        drawer = SBDrawer(_scale: scale, scene: scene)
    }
    
    // on touch
    func onTouch(point :CGPoint) {

        // check touch position
        let idx = scale.convert(point.x, y: point.y)
        if !isPossible(idx.ix, iy: idx.iy) {
            return
        }
        
        if turn == TURN_FIRST {
            state[idx.ix, idx.iy] = Piece.STAR
            drawer.addPiece(idx.ix, y: idx.iy, p: Piece.STAR)
            turn = TURN_LAST
            
        } else {
            state[idx.ix, idx.iy] = Piece.BOSE
            drawer.addPiece(idx.ix, y: idx.iy, p: Piece.BOSE)
            turn = TURN_FIRST
            
        }
        
        let check = checkAligned(state)
        if check != Piece.NONE {
            // TODO show dialog for debug
            let alert = UIAlertView()
            alert.title = "title"
            if check == Piece.STAR {
                alert.message = "win star"
            } else {
                alert.message = "win bose"
            }
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }

    // check can put piece
    func isPossible(ix :Int, iy :Int) -> Bool {
        if ix < 0 || iy < 0 {
            return false
        }
        if state[ix, iy] != Piece.NONE {
            return false
        }
        return true
    }
    
    // check aligned
    func checkAligned(state :SBState) -> Piece {
        var star :Int = 0
        var bose :Int = 0
        
        // check side
        for i in 0..<HEIGHT {
            for j in 0..<WIDTH {
                let piece = state[j, i]!
                if piece == Piece.STAR {
                    star += 1
                } else if piece == Piece.BOSE {
                    bose += 1
                }
            }
            if star == 3 {
                return Piece.STAR
            } else if bose == 3 {
                return Piece.BOSE
            }
            star = 0
            bose = 0
        }
        
        // check height
        for i in 0..<WIDTH {
            for j in 0..<HEIGHT {
                let piece = state[i, j]!
                if piece == Piece.STAR {
                    star += 1
                } else if piece == Piece.BOSE {
                    bose += 1
                }
            }
            if star == 3 {
                return Piece.STAR
            } else if bose == 3 {
                return Piece.BOSE
            }
            star = 0
            bose = 0
        }
        return Piece.NONE
    }
}