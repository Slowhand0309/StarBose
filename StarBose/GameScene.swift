//
//  GameScene.swift
//  StarBose
//
//  Created by MrSmall on 2015/06/26.
//  Copyright (c) 2015年 MrSmall. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var manager :SBManager!

    // not supported construct.
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        manager = SBManager(scene: self)
    }
    
    // update
    override func update(currentTime: CFTimeInterval) {
    }
    
    // handling on touch
    func onTouch(point :CGPoint) {
        let position = CGPoint(x: point.x, y: point.y)
        manager.onTouch(position)
    }
}
