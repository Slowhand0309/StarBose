//
//  SBIntelligence.swift
//  StarBose
//
//  Created by MrSmall on 2015/07/03.
//  Copyright (c) 2015年 MrSmall. All rights reserved.
//

import Foundation

public class SBIntelligence {
    
    let piece :Piece
    
    // Constructor
    public init (p :Piece) {
        piece = p
    }
    
    // calculate to put place
    func cacl(state :SBState) -> (ix :Int, iy :Int) {
        return (-1, -1)
    }
}
