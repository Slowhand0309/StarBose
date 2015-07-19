//
//  SBDrawer.swift
//  StarBose
//
//  Created by MrSmall on 2015/07/03.
//  Copyright (c) 2015年 MrSmall. All rights reserved.
//

import Foundation
import SpriteKit

// width size rate
let SIZE_ACPECT_RATE :CGFloat = 0.9

class SBDrawer {
    
    var divSizeX :CGFloat! // width / 3
    var divSizeY :CGFloat! // height / 3
    var diffX :CGFloat!
    var diffY :CGFloat!
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
        let w = gameScene.size.width * SIZE_ACPECT_RATE
        diffX = (gameScene.size.width - w) / 2.0
        diffY = (gameScene.size.height - w) / 2.0
        let center = CGPointMake(gameScene.size.width / 2, gameScene.size.height / 2)
        size = CGSize(width: w, height: w)
        
        // create box node
        let box = SKSpriteNode(color: SKColor.whiteColor(), size: size)
        box.position = center
        gameScene.addChild(box)
        
        // draw line
        divSizeX = size.width / CGFloat(WIDTH)
        divSizeY = size.height / CGFloat(HEIGHT)
        
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
    
    // check position
    func isPossible(x :CGFloat, y :CGFloat) -> Bool {
        if x < diffX || (size.width + diffX) < x {
            return false
        }
        if y < diffY || (size.height + diffY) < y {
            return false
        }
        return true
    }
    
    // create star bose image
    // TODO not supported custom image!
    func createNode(p :Piece) -> SKShapeNode! {
        
        var img :SKShapeNode!
        if p == Piece.STAR {
            img = SKShapeNode(circleOfRadius: divSizeX / 2.0) // TODO for debug
            img.fillColor = SKColor.blueColor()
            
        } else if p == Piece.BOSE {
            img = SKShapeNode(circleOfRadius: divSizeX / 2.0) // TODO for debug
            img.fillColor = SKColor.redColor()
        }
        return img
    }
    
    // draw piece
    func addPiece(x :CGFloat, y :CGFloat, p :Piece) {
        
        if !isPossible(x, y: y) {
            return
        }
        
        if p == Piece.STAR {
            let star = createNode(p)
            star.position = convert(x, y: y)
            gameScene.addChild(star)
            
        } else if p == Piece.BOSE {
            let bose = createNode(p)
            bose.position = convert(x, y: y)
            gameScene.addChild(bose)
            
        }
    }

    // convert touch position to piece position
    func convert(x :CGFloat, y :CGFloat) -> CGPoint {
        
        // convert Absolute position
        let dex = Int(x - diffX) / Int(divSizeX)
        let dey = Int(y - diffY) / Int(divSizeY)
        
        let bx = CGFloat(dex) * divSizeX + diffX + divSizeX / 2.0
        let by = CGFloat(dey) * divSizeY + diffY + divSizeY / 2.0
        
        return CGPointMake(bx, by)
    }
}