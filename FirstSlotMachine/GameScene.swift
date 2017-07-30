//
//  GameScene.swift
//  FirstSlotMachine
//
//  Created by Deborah Graham on 7/30/17.
//  Copyright © 2017 Deborah Graham. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let slotOptions = ["🌾", "💐", "🌷", "🌹", "🥀", "🌻", "🌼", "🌸", "🌺", "🌱", "🎋"]
    var currentWheelValue1: String = ""
    var currentWheelValue2: String = ""
    var currentWheelValue3: String = ""
    
    var wheelActive: Bool = false
    
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        /*self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        */
        // Create shape node to use during mouse interaction
        /*let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
         */
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*if let label = self.label {
         label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
         }
         
         for t in touches { self.touchDown(atPoint: t.location(in: self)) }
         */
        if (wheelActive == false) {
            print("spinning...")
            wheelActive = true
            let wait:SKAction = SKAction.wait(forDuration: 1)
            let spinWheel1:SKAction = SKAction.run({self.spinWheel(whichWheel: 1)})
            let spinWheel2:SKAction = SKAction.run({self.spinWheel(whichWheel: 2)})
            let spinWheel3:SKAction = SKAction.run({self.spinWheel(whichWheel: 3)})
            let testWheelValues:SKAction = SKAction.run({self.testValues()})
            
            //self.run(action(forKey: SKAction.sequence([wait, spinWheel1, wait, spinWheel2, wait, spinWheel3, wait, testWheelValues]))
            
            self.run(SKAction.sequence([wait, spinWheel1, wait, spinWheel2, wait, spinWheel3, wait, testWheelValues]))
        }
    }
    
    func spinWheel(whichWheel: Int) {
        let randomNumber = arc4random_uniform(UInt32(slotOptions.count))
        let wheelPick = slotOptions[Int(randomNumber)]
        
        print ("Wheel \(whichWheel) spun a value of \(wheelPick)")
        
        if (whichWheel == 1) {
            currentWheelValue1 = wheelPick
        } else if (whichWheel == 2) {
            currentWheelValue2 = wheelPick
        } else if (whichWheel == 3) {
            currentWheelValue3 = wheelPick
        }

        
    }
    
    func testValues() {
        if (currentWheelValue1 == currentWheelValue2 && currentWheelValue2 == currentWheelValue3) {
            print("they all match!!!!")
        } else if ( currentWheelValue1 == currentWheelValue2) {
            print("some of them match!")
        } else {
            print("you lost.")

        }
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
