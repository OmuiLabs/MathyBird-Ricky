//
//  GameScene.swift
//  MathyBird Shared
//
//  Created by Ricky Pan on 09/28/23.
//

import SpriteKit
import Foundation
import SwiftUI

struct fisica {
  static let player : UInt32 = 0x1 << 1
  static let piso : UInt32 = 0x1 << 2
  static let tubo : UInt32 = 0x1 << 3
  static let cubo : UInt32 = 0x1 << 4
}

class GameScene: SKScene {
    
    var fondo = SKSpriteNode()
    var player = SKSpriteNode()
    
    override func didMove(to view: SKView){
        
        fondo = SKSpriteNode(imageNamed: "fondo")
        player = SKSpriteNode(imageNamed: "magicarp")
        
        fondo.setScale(0.6)
        fondo.zPosition = -1
        
         player.position = CGPoint(x: -450, y: 0)
//        player.position = CGPoint(x: self.frame.width / 2 - player.frame.width, y: self.frame.height / 2)
        player.setScale(0.6)
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        player.physicsBody = SKPhysicsBody(circleOfRadius: max(
          player.size.width / 2, player.size.height / 2))
        player.physicsBody?.categoryBitMask = fisica.player
        player.physicsBody?.collisionBitMask = fisica.piso | fisica.tubo | fisica.cubo
        player.physicsBody?.contactTestBitMask = fisica.piso | fisica.tubo | fisica.cubo
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = true

        self.addChild(fondo)
        self.addChild(player)

        muros()
        cubos()
        pisos()
    }
    
    override func touchesBegan(_ touches: Set <UITouch>, with event: UIEvent?){
        player.physicsBody?.velocity = CGVectorMake(0, 0)
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
            
    }

    func muros() {
        let tubos = SKNode()

        let tuboBot = SKSpriteNode(imageNamed: "tuboG")
        let tuboTop = SKSpriteNode(imageNamed: "tuboG")

        tuboBot.position = CGPoint(x: 0, y: -200)
        tuboBot.setScale(0.6)
        tuboBot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
          width: tuboBot.size.width, height: tuboBot.size.height))
        tuboBot.physicsBody?.categoryBitMask = fisica.tubo
        tuboBot.physicsBody?.collisionBitMask = fisica.player
        tuboBot.physicsBody?.contactTestBitMask = fisica.player
        tuboBot.physicsBody?.isDynamic = false
        tuboBot.physicsBody?.affectedByGravity = false
        
        tuboTop.position = CGPoint(x: 0, y: 250)
        tuboTop.zRotation = Angle(degrees: 180).radians
        tuboTop.setScale(0.6)
        tuboTop.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
          width: tuboTop.size.width, height: tuboTop.size.height))
        tuboTop.physicsBody?.categoryBitMask = fisica.tubo
        tuboTop.physicsBody?.collisionBitMask = fisica.player
        tuboTop.physicsBody?.contactTestBitMask = fisica.player
        tuboTop.physicsBody?.isDynamic = false
        tuboTop.physicsBody?.affectedByGravity = false

        tubos.addChild(tuboTop)
        tubos.addChild(tuboBot)

        self.addChild(tubos)
    }

    func cubos() {
        let cubos = SKNode()

        let cubo = SKSpriteNode(imageNamed: "block")

        cubo.position = CGPoint(x: 0, y: 25)
        cubo.setScale(0.6)
        cubo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
          width: cubo.size.width, height: cubo.size.height))
        cubo.physicsBody?.categoryBitMask = fisica.cubo
        cubo.physicsBody?.collisionBitMask = fisica.player
        cubo.physicsBody?.contactTestBitMask = fisica.player
        cubo.physicsBody?.isDynamic = false
        cubo.physicsBody?.affectedByGravity = false

        cubos.addChild(cubo)

        self.addChild(cubos)
    }

    func pisos() {
        let pisos = SKNode()

        let pisoBot = SKSpriteNode(imageNamed: "piso")
        let pisoTop = SKSpriteNode(imageNamed: "piso")

        pisoBot.setScale(0.6)
        pisoBot.position = CGPoint(x: 0, y: -283)
        pisoBot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
          width: pisoBot.size.width, height: pisoBot.size.height))
        pisoBot.physicsBody?.categoryBitMask = fisica.piso
        pisoBot.physicsBody?.collisionBitMask = fisica.player
        pisoBot.physicsBody?.contactTestBitMask = fisica.player
        pisoBot.physicsBody?.restitution = 0.3
        pisoBot.physicsBody?.isDynamic = false
        pisoBot.physicsBody?.affectedByGravity = false

        pisoTop.setScale(0.6)
        pisoTop.zRotation = Angle(degrees: 180).radians
        pisoTop.position = CGPoint(x: 0, y: 335)
        pisoTop.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
          width: pisoTop.size.width, height: pisoTop.size.height))
        pisoTop.physicsBody?.categoryBitMask = fisica.piso
        pisoTop.physicsBody?.collisionBitMask = fisica.player
        pisoTop.physicsBody?.contactTestBitMask = fisica.player
        pisoTop.physicsBody?.isDynamic = false
        pisoTop.physicsBody?.affectedByGravity = false

        pisos.addChild(pisoTop)
        pisos.addChild(pisoBot)

        self.addChild(pisos)
    }
    
    override func update(_ currentTime: CFTimeInterval){
        
    }
    

}
