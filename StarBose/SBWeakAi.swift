//
//  SBWeakIntelligence.swift
//  StarBose
//
//  Created by MrSmall on 2015/07/28.
//  Copyright © 2015年 MrSmall. All rights reserved.
//

import Foundation

public class SBWeakAi : SBIntelligence {
    
    // Constructor
    public override init(p :Piece) {
        super.init(p: p)
    }
    
    // Put simply to can be placed in a continuous place
    override func cacl(state :SBState) -> (ix :Int, iy :Int) {
        
        var flag :Bool
        // Check side
        for y in 0..<HEIGHT {
            flag = false
            for x in 0..<WIDTH {
                let piece = state[x, y]
                if flag && piece == Piece.NONE {
                    return (x, y)
                } else {
                    if piece == self.piece {
                        flag = true
                    }
                }
            }
        }

        // If it did not hit First it returns an empty place
        for y in 0..<HEIGHT {
            for x in 0..<WIDTH {
                let piece = state[x, y]
                if piece == Piece.NONE {
                    return (x, y)
                }
            }
        }
        return (-1, -1)
    }
}
