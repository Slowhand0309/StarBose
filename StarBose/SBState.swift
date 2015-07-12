//
//  SBState.swift
//  StarBose
//
//  Created by MrSmall on 2015/07/04.
//  Copyright (c) 2015年 MrSmall. All rights reserved.
//

import Foundation

// Star(○), Bose(×) define.
public enum Piece :Int {
    case NONE = 0 // none
    case STAR     // ○
    case BOSE     // ×
}

// board state class
class SBState {

    
    var pieces :[Piece?]
    
    // create board array
    init() {
        pieces = Array(count: (WIDTH * HEIGHT), repeatedValue: Piece.NONE)
    }
    
    // value obtained in [w, h]
    subscript (width :Int, height :Int) -> Piece? {
        get {
            if isRange(width, h: height) {
                return pieces[height * HEIGHT + width]
            }
            return Piece.NONE
        }
        set {
            if isRange(width, h: height) {
                pieces[height * HEIGHT + width] = newValue
            }
        }
    }
    
    // range check
    func isRange(w :Int, h :Int) -> Bool {
        if w < 0 || w > WIDTH
            || h < 0 || h > HEIGHT {
                return false
        }
        return true
    }
}