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
    
    var gameScene :GameScene
    var size :CGSize!

    // initalize drawer
    init(scene :GameScene) {
        gameScene = scene
        
        // TODO custom image
        
        addBackgroundNode()
    }
    
    // add background shape node
    func addBackgroundNode() {
        
        // adjust size
        var w = gameScene.size.width * 0.9
        var diffX = (gameScene.size.width - w) / 2.0
        var diffY = (gameScene.size.height - w) / 2.0
        var center = CGPointMake(gameScene.size.width / 2, gameScene.size.height / 2)
        size = CGSize(width: w, height: w)
        
        // create box node
        let box = SKSpriteNode(color: SKColor.whiteColor(), size: size)
        box.position = center
        gameScene.addChild(box)
        
        // draw line
        let divSizeX = size.width / CGFloat(WIDTH)
        let divSizeY = size.height / CGFloat(HEIGHT)
        
        for i in 0..<WIDTH {
            let line = SKShapeNode()
            let path = UIBezierPath()
            
            path.moveToPoint(CGPointMake((divSizeX * CGFloat(i)) + diffX, size.height + diffY))
            path.addLineToPoint(CGPointMake((divSizeX * CGFloat(i)) + diffX, diffY))
            
            line.path = path.CGPath
            line.strokeColor = SKColor.blackColor()
            line.lineWidth = 1.0
            gameScene.addChild(line)
        }
        
        for j in 0..<HEIGHT {
            let line = SKShapeNode()
            let path = UIBezierPath()
            
            path.moveToPoint(CGPointMake(diffX, (divSizeY * CGFloat(j)) + diffY))
            path.addLineToPoint(CGPointMake(size.width + diffX, (divSizeY * CGFloat(j)) + diffY))
            
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
            img = SKShapeNode(circleOfRadius: 60) // TODO for debug
            img.fillColor = SKColor.blueColor()
            
        } else if p == Piece.BOSE {
            img = SKShapeNode(circleOfRadius: 60) // TODO for debug
            img.fillColor = SKColor.redColor()
        }
        return img
    }
    
    // draw piece
    func addPiece(x :CGFloat, y :CGFloat, p :Piece) {
        if p == Piece.STAR {
            var star = createNode(p)
            star.position = CGPointMake(x, y)
            gameScene.addChild(star)
            
        } else if p == Piece.BOSE {
            var bose = createNode(p)
            bose.position = CGPointMake(x, y)
            gameScene.addChild(bose)
            
        }
    }
}