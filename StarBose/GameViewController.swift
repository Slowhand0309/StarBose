//
//  GameViewController.swift
//  StarBose
//
//  Created by MrSmall on 2015/06/26.
//  Copyright (c) 2015年 MrSmall. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController, UIGestureRecognizerDelegate {

    var scene :GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = view as! SKView
        
        // initalize GameScene
        scene = GameScene(size: skView.bounds.size)
        skView.presentScene(scene)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // detect a tap of the user
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        // retrieve the SKView
        let skView = self.view as! SKView
        
        // convert tap point
        let p = sender.locationInView(skView)
        scene.onTouch(p)
    }
}
