//
//  GameScene.swift
//  MathyBird Shared
//
//  Created by Ricky Pan on 09/28/23.
//

import SpriteKit
import Foundation
import SwiftUI

class GameScene: SKScene {
    
    var fondo = SKSpriteNode()
    
    var player = SKSpriteNode()
    var cubo = SKSpriteNode()
    var tuboBot = SKSpriteNode()
    var tuboTop = SKSpriteNode()
    
    
    override func didMove(to view: SKView){
        
        fondo = SKSpriteNode(imageNamed: "fondo")
        player = SKSpriteNode(imageNamed: "magicarp")
        cubo = SKSpriteNode(imageNamed: "block")
        tuboBot = SKSpriteNode(imageNamed: "tuboG")
        tuboTop = SKSpriteNode(imageNamed: "tuboG")
        
        fondo.setScale(0.6)
        fondo.zPosition = -1
        
        player.position = CGPoint(x: -450, y: 0)
        player.setScale(0.6)
        
        tuboBot.position = CGPoint(x: 0, y: -200)
        tuboBot.setScale(0.6)
        
        tuboTop.position = CGPoint(x: 0, y: 250)
        tuboTop.zRotation = Angle(degrees: 180).radians
        tuboTop.setScale(0.6)
        
        cubo.position = CGPoint(x: 0, y: 25)
        cubo.setScale(0.6)

        self.addChild(fondo)
        self.addChild(player)
        self.addChild(cubo)
        self.addChild(tuboTop)
        self.addChild(tuboBot)
    }
    
    override func touchesBegan(_ touches: Set <UITouch>, with event: UIEvent?){
        
    }
    
    override func update(_ currentTime: CFTimeInterval){
        
    }
    

}

