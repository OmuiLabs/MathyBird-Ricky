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
static let problem : UInt32 = 0x1 << 5
}

struct OperacionMatematica {
    let operando1: Int
    let operando2: Int
    let operador: String
    let resultadoCorrecto: Int
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var fondo = SKSpriteNode()
    var player = SKSpriteNode()
    
    var tubos = SKNode()
    var cubos = SKNode()
    
    var respuestaCorrecta = SKLabelNode()
    var respuestaIncorrecta = SKLabelNode()
    let problemaLabel = SKLabelNode()
    
    var moverRemover = SKAction()
    
    var comienzo = Bool()
    
    var problema = Int()
    
    var timer: Timer?
    var tiempoTranscurrido: TimeInterval = 0
    
    let final = SKLabelNode(text: "! YOU LOSE !")
    
    var velocidades: CGFloat = 10
    
    override func didMove(to view: SKView){
        
        self .physicsWorld.contactDelegate = self
        
        fondo = SKSpriteNode(imageNamed: "fondo")
        player = SKSpriteNode(imageNamed: "magicarp")
        
        fondo.setScale(0.6)
        fondo.zPosition = -1
        
        player.position = CGPoint(x: -450, y: 0)
        player.zPosition = 2
        player.size = CGSize(width: 125, height: 125)
        player.setScale(0.6)
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        player.physicsBody = SKPhysicsBody(circleOfRadius: max(
          player.size.width / 2, player.size.height / 2))
        player.physicsBody?.categoryBitMask = fisica.player
        player.physicsBody?.collisionBitMask = fisica.piso | fisica.tubo | fisica.cubo | fisica.problem
        player.physicsBody?.contactTestBitMask = fisica.piso | fisica.tubo | fisica.cubo | fisica.problem
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = true

        self.addChild(fondo)
        self.addChild(player)

        pisos()
    }
    
    func generarOperacionMatematica() {
        
        
        let problemas = SKSpriteNode()
        
        problemas.size = CGSize(width: 1, height: 100)
        problemas.position = CGPoint(x: self.frame.width / 6 + 250 , y: self.frame.height / 6 )
        problemas.physicsBody = SKPhysicsBody(rectangleOf: problemas.size)
        problemas.physicsBody?.affectedByGravity = false
        problemas.physicsBody?.isDynamic = false
        problemas.physicsBody?.categoryBitMask = fisica.problem
        problemas.physicsBody?.collisionBitMask = 0
        problemas.physicsBody?.contactTestBitMask = fisica.player
        problemas.color = SKColor.blue
        
        let randomPosition: CGFloat = [125.0, -75.0].randomElement() ?? 125.0
        problemas.position.y = tubos.position.y + randomPosition
        tubos.addChild(problemas)
        
           let operando1 = Int.random(in: 1...10)
           let operando2 = Int.random(in: 1...10)
           let operadores = ["+", "-"]
           let operador = operadores.randomElement()!
           
           var resultadoCorrecto: Int
           
           switch operador {
           case "+":
               resultadoCorrecto = operando1 + operando2
           case "-":
               resultadoCorrecto = operando1 - operando2
//           case "*":
//               resultadoCorrecto = operando1 * operando2
//           case "/":
//               resultadoCorrecto = operando1 / operando2
           default:
               resultadoCorrecto = 0
           }
           
           let respuestaCorrecta = SKLabelNode(text: "\(resultadoCorrecto)")
           let respuestaIncorrecta = SKLabelNode(text: "\(resultadoCorrecto + 1)") // Respuesta incorrecta
           
           // Posiciones de las respuestas
           respuestaCorrecta.position = CGPoint(x: self.frame.width / 6 + 265, y: -problemas.position.y)
            respuestaCorrecta.color = SKColor.black
           respuestaIncorrecta.position = CGPoint(x: self.frame.width / 6 + 265, y: problemas.position.y)
        respuestaIncorrecta.color = SKColor.red
        
        respuestaCorrecta.fontSize = 50
        respuestaIncorrecta.fontSize = 50
        respuestaCorrecta.fontName = "Helvetica-Bold"
        respuestaIncorrecta.fontName = "Helvetica-Bold"
        respuestaCorrecta.fontColor = .black
        respuestaIncorrecta.fontColor = .black
        
        let problemaLabel = SKLabelNode(fontNamed: "Helvetica-Bold")
           problemaLabel.text = "\(operando1) \(operador) \(operando2)"
           problemaLabel.fontSize = 50
           problemaLabel.fontColor = .black
           problemaLabel.position = CGPoint(x: 200, y: 250)

        
            respuestaCorrecta.run(moverRemover)
            respuestaIncorrecta.run(moverRemover)
            problemaLabel.run(moverRemover)
           
           // Agregar las respuestas a la escena
           self.addChild(respuestaCorrecta)
           self.addChild(respuestaIncorrecta)
            self.addChild(problemaLabel)
       }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == fisica.problem && secondBody.categoryBitMask == fisica.player || firstBody.categoryBitMask == fisica.player && secondBody.categoryBitMask == fisica.problem{
            
            endGame()
        }
    }
    
    override func touchesBegan(_ touches: Set <UITouch>, with event: UIEvent?){
        if comienzo == false {
            comienzo = true
            
            let generar = SKAction.run({
                () in
                self.muros()
                self.block()
                self.generarOperacionMatematica()
            })

            let delay = SKAction.wait(forDuration: 10)
            let  generarDelay = SKAction.sequence([generar, delay])
            let generarRepetido = SKAction.repeatForever(generarDelay)
            self.run(generarRepetido)

            let distanciaTubo = CGFloat(self.frame.width + tubos.frame.width)

            // duration es la duracion para la resta mientras mas pequenio es mas rapido se mueve mas grande mas lento
            let moverTubo = SKAction.moveBy(x: -distanciaTubo, y: 0, duration: velocidades)


            let quitarTubo = SKAction.removeFromParent()
            moverRemover = SKAction.sequence([moverTubo, quitarTubo])
            
            player.physicsBody?.velocity = CGVectorMake(0, 0)
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ajustarVelocidad), userInfo: nil, repeats: true)
            
        }else{
            player.physicsBody?.velocity = CGVectorMake(0, 0)
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
        }
            
    }

    func muros() {
        tubos = SKNode()

        let tuboBot = SKSpriteNode(imageNamed: "tuboG")
        let tuboTop = SKSpriteNode(imageNamed: "tuboG")

        tuboBot.position = CGPoint(x: 500, y: -200)
        tuboBot.setScale(0.6)
        tuboBot.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
          width: tuboBot.size.width, height: tuboBot.size.height))
        tuboBot.physicsBody?.categoryBitMask = fisica.tubo
        tuboBot.physicsBody?.collisionBitMask = fisica.player
        tuboBot.physicsBody?.contactTestBitMask = fisica.player
        tuboBot.physicsBody?.isDynamic = false
        tuboBot.physicsBody?.affectedByGravity = false
        
        tuboTop.position = CGPoint(x: 500, y: 250)
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


        tubos.run(moverRemover)

        self.addChild(tubos)
    }

    func block() {
        cubos = SKNode()

        let cubo = SKSpriteNode(imageNamed: "block")

        cubo.position = CGPoint(x: 500, y: 25)
        cubo.setScale(0.6)
        cubo.size = CGSize(width: 100, height: 100)
        cubo.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
          width: cubo.size.width - 49, height: cubo.size.height - 49))
        cubo.physicsBody?.categoryBitMask = fisica.cubo
        cubo.physicsBody?.collisionBitMask = fisica.player
        cubo.physicsBody?.contactTestBitMask = fisica.player
        cubo.physicsBody?.isDynamic = false
        cubo.physicsBody?.affectedByGravity = false

        cubos.addChild(cubo)

        cubos.run(moverRemover)

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
        if player.position.y < -350 || player.position.x < -625 {
            endGame()
        }else{
            
            
        }
    }
    
    @objc func ajustarVelocidad() {
        // Reduce la velocidad actual en 0.1
        tiempoTranscurrido += 1
        
        print("tiempo:", tiempoTranscurrido)
                
                if tiempoTranscurrido >= 10.0 {
                    if velocidades != 1{
                        velocidades -= 1
                        
                    }
                    
                    // Actualiza la duración de las acciones
                    let moverTubo = SKAction.moveBy(x: -self.frame.width + tubos.frame.width, y: 0, duration: velocidades)
                    let quitarTubo = SKAction.removeFromParent()
                    moverRemover = SKAction.sequence([moverTubo, quitarTubo])
                    
                    tiempoTranscurrido = 0  // Reinicia el contador
                }
    }
    
    func endGame() {
        
        self.removeAllChildren()
        self.removeAllActions()
        
        final.fontSize = 50
        final.position = CGPoint(x: 0, y: -250)
        final.fontName = "Futura Bold"
        final.fontColor = .red
        addChild(final)
        
        let particle = SKSpriteNode(imageNamed: "bird")
        particle.setScale(1)
        addChild(particle)
    }
}
