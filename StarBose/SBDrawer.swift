//
//  SBDrawer.swift
//  StarBose
//
//  Created by MrSmall on 2015/07/03.
//  Copyright (c) 2015年 MrSmall. All rights reserved.
//

import Foundation
import SpriteKit



class SBDrawer {

    var scale :SBScale
    var gameScene :GameScene

    // initalize drawer
    init(_scale :SBScale, scene :GameScene) {
        scale = _scale
        gameScene = scene
        
        // TODO custom image
        
        addBackgroundNode()
    }
    
    // add background shape node
    func addBackgroundNode() {
        
        // create box node
        let box = SKSpriteNode(color: SKColor.whiteColor(), size: scale.size)
        box.position = CGPointMake(gameScene.size.width / 2, gameScene.size.height / 2)
        gameScene.addChild(box)
        
        for i in 0..<WIDTH {
            let line = SKShapeNode()
            let path = UIBezierPath()
            
            path.moveToPoint(CGPointMake((scale.divSizeX * CGFloat(i)) + scale.diffX, scale.size.height + scale.diffY))
            path.addLineToPoint(CGPointMake((scale.divSizeX * CGFloat(i)) + scale.diffX, scale.diffY))
            
            line.path = path.CGPath
            line.strokeColor = SKColor.blackColor()
            line.lineWidth = 1.0
            gameScene.addChild(line)
        }
        
        for j in 0..<HEIGHT {
            let line = SKShapeNode()
            let path = UIBezierPath()
            
            path.moveToPoint(CGPointMake(scale.diffX, (scale.divSizeY * CGFloat(j)) + scale.diffY))
            path.addLineToPoint(CGPointMake(scale.size.width + scale.diffX, (scale.divSizeY * CGFloat(j)) + scale.diffY))
            
            line.path = path.CGPath
            line.strokeColor = SKColor.blackColor()
            line.lineWidth = 1.0
            gameScene.addChild(line)
        }

    }
    
    // create star bose image
    // TODO not supported custom image!
    func createNode(p :Piece) -> SKShapeNode! {
        
        var img :SKShapeNode!
        if p == Piece.STAR {
            img = SKShapeNode(circleOfRadius: scale.divSizeX / 2.0) // TODO for debug
            img.fillColor = SKColor.blueColor()
            
        } else if p == Piece.BOSE {
            img = SKShapeNode(circleOfRadius: scale.divSizeX / 2.0) // TODO for debug
            img.fillColor = SKColor.redColor()
        }
        return img
    }
    
    // draw piece
    func addPiece(x :Int, y :Int, p :Piece) {
        
        let node = createNode(p)
        node.position = convert(x, y: y)
        gameScene.addChild(node)
    }

    // convert touch position to piece position
    func convert(x :Int, y :Int) -> CGPoint {
        
        let bx = CGFloat(x) * scale.divSizeX + scale.diffX + scale.divSizeX / 2.0
        let by = gameScene.size.height - (CGFloat(y) * scale.divSizeY + scale.diffY + scale.divSizeY / 2.0)
        return CGPointMake(bx, by)
    }
}