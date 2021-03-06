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
let TURN_COMP = 2

// declare Squares : 3×3
let WIDTH :Int = 3
let HEIGHT :Int = 3

// StarBose game management class.
class SBManager {

    var turn :Int!
    var InteligenceTurn :Int
    
    var scale :SBScale
    var drawer :SBDrawer!
    var state :SBState!
    var inteligence :SBIntelligence
    var message :UIButton!

    // initalize
    init(scene :GameScene) {
        turn = TURN_FIRST
        // TODO config
        InteligenceTurn = TURN_LAST
        
        state = SBState()
        scale = SBScale(scene: scene)
        drawer = SBDrawer(_scale: scale, scene: scene)
        inteligence = SBWeakAi(p: Piece.BOSE) // TODO decide to look at the turn
    }
    
    // set ui button
    func setMessageButton(button :UIButton!) {
        self.message = button
    }
    
    // on touch
    func onTouch(point :CGPoint) {

        if turn == InteligenceTurn ||
           turn == TURN_COMP {
           // Skip inteligence turn
            return
        }
        
        // check touch position
        let idx = scale.convert(point.x, y: point.y)
        if !isPossible(idx.ix, iy: idx.iy) {
            return
        }
        
        putPiece(idx.ix, y: idx.iy)
        if turn == InteligenceTurn {
            // To think in AI
            let idx = inteligence.cacl(state)
            if idx.ix != -1 && idx.iy != -1 {
                let delay = 1.0 * Double(NSEC_PER_SEC)
                let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue(), {
                    self.putPiece(idx.ix, y: idx.iy)
                })
            }
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
    
    // put piece
    func putPiece(x :Int, y :Int) {
        
        if turn == TURN_FIRST {
            state[x, y] = Piece.STAR
            drawer.addPiece(x, y: y, p: Piece.STAR)
            turn = TURN_LAST
        } else {
            state[x, y] = Piece.BOSE
            drawer.addPiece(x, y: y, p: Piece.BOSE)
            turn = TURN_FIRST
        }
        
        let check = checkAligned(x, y: y)
        if check != Piece.NONE {
            turn = TURN_COMP
            // TODO show dialog for debug
            let alert = UIAlertView()
            var msg = "Win Star!! back title"
            alert.title = "title"
            if check == Piece.STAR {
                alert.message = "win star"
            } else {
                alert.message = "win bose"
                msg = "Win Bose!! back title"
            }
            alert.addButtonWithTitle("OK")
            alert.show()
            
            self.message.setTitle(msg, forState: UIControlState.Normal)
            self.message.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        }
    }
    
    // check aligned
    func checkAligned(x :Int, y :Int) -> Piece {
        var countX :Int = 0
        // check side
        for i in 0..<WIDTH {
            let piece = state[i, y]
            countX += countUp(piece!)
        }
        
        // chekc height
        var countY :Int = 0
        for j in 0..<HEIGHT {
            let piece = state[x, j]
            countY += countUp(piece!)
        }
        
        // check slanting
        var countLeft :Int = 0
        var countRight :Int = 0
        var upX :Int = 0
        var downX :Int = WIDTH - 1
        for y in 0..<HEIGHT {
            let pieceUp = state[upX, y]
            countLeft += countUp(pieceUp!)
            upX++
            
            let pieceDown = state[downX, y]
            countRight = countUp(pieceDown!)
            downX--
        }
        
        if countX == 3
            || countY == 3
            || countLeft == 3
            || countRight == 3 {
            return Piece.STAR
        } else if countX == -3
            || countY == -3
            || countLeft == -3
            || countRight == -3 {
            return Piece.BOSE
        }
        return Piece.NONE
    }
    
    // count calc
    func countUp(p :Piece) -> Int {
        if p == Piece.STAR {
            return 1
        } else if p == Piece.BOSE {
            return -1
        }
        return 0
    }
}