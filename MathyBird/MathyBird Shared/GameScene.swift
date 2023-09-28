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
    var piso = SKSpriteNode()
    
    
    override func didMove(to view: SKView){
        
        fondo = SKSpriteNode(imageNamed: "fondo")
        player = SKSpriteNode(imageNamed: "magicarp")
        cubo = SKSpriteNode(imageNamed: "block")
        tuboBot = SKSpriteNode(imageNamed: "tuboG")
        tuboTop = SKSpriteNode(imageNamed: "tuboG")
        piso = SKSpriteNode(imageNamed: "piso")
        
        fondo.setScale(0.6)
        fondo.zPosition = -1
        
        piso.setScale(0.6)
        piso.position = CGPoint(x: 0, y: -283)
        piso.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: piso.size.width,
            height: piso.size.height))
        piso.physicsBody?.restitution = 0.5
        piso.physicsBody?.isDynamic = false
        
        player.position = CGPoint(x: -450, y: 0)
        player.setScale(0.6)
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        player.physicsBody = SKPhysicsBody(circleOfRadius: max(player.size.width / 2,
            player.size.height / 2))

        
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
        self.addChild(piso)
    }
    
    override func touchesBegan(_ touches: Set <UITouch>, with event: UIEvent?){
        
    }
    
    override func update(_ currentTime: CFTimeInterval){
        
    }
    

}

