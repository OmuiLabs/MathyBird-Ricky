//
//  GameViewController.swift
//  MathyBird iOS
//
//  Created by Ricky Pan on 09/28/23.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            if let scene = SKScene(fileNamed: "GameScene"){
                scene.scaleMode = .aspectFill
                
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
