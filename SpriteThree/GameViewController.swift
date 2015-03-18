//
//  GameViewController.swift
//  SpriteThree
//
//  Created by Morgan Wilde on 07/03/2015.
//  Copyright (c) 2015 Morgan Wilde. All rights reserved.
//

import Foundation
import SpriteKit

class GameViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var spriteKitView: SKView!
    
    // Properties
    var scene: SKScene!
    var playerCharacterNode: SKSpriteNode!
    var sceneWidth: CGFloat!
    var sceneHeight: CGFloat!
    
    // Callback methods
    override func viewDidLoad() {
        createSceneInitial()
        createPlayerCharacter()
        spriteKitView.contentMode = .ScaleToFill
        spriteKitView.presentScene(scene)
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let touch = touch as UITouch
            let touchLocation = touch.locationInView(spriteKitView)
            let xDelta = touchLocation.x - getPlayerCharacterCenterPoint().x
            let yDelta = (sceneHeight - touchLocation.y) - getPlayerCharacterCenterPoint().y
            movePlayerCharacterToOneDirection(deltaX: xDelta, deltaY: yDelta)
        }
    }
    
    
    
    
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        updateSceneSize(toInterfaceOrientation)
        println("willAnimateRotationToInterfaceOrientation")
        super.willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration: duration)
    }
    
    
    
    
    // Methods
    func createSceneInitial() {
        scene = SKScene(size: spriteKitView.frame.size)
        scene.scaleMode = .AspectFit
        // Sace scene size to properties
        sceneWidth = view.frame.width
        sceneHeight = view.frame.height
        // Update orientation
        if sceneWidth < sceneHeight {
            updateSceneSize(.Portrait)
        } else {
            updateSceneSize(.LandscapeRight)
        }
    }
    func updateSceneSize(toInterfaceOrientation: UIInterfaceOrientation) {
        switch (toInterfaceOrientation) {
            // Portrait orientation
        case .Portrait: fallthrough
        case .PortraitUpsideDown:
            scene.size.width = sceneWidth
            scene.size.height = sceneHeight
            // Landscape orientation
        case .LandscapeRight: fallthrough
        case .LandscapeLeft:
            scene.size.width = sceneHeight
            scene.size.height = sceneWidth
            // Error
        case .Unknown: break
        }
        println("update")
    }
    
    
    
    
    
    
    func createPlayerCharacter() {
        // Create
        playerCharacterNode = SKSpriteNode(imageNamed: "sprite-player-character.png")
        // Customize
        playerCharacterNode.anchorPoint = CGPoint(x: 0, y: 0)
        playerCharacterNode.position = CGPoint(x: 50, y: 100)
        // Add to hierarchy
        scene.addChild(playerCharacterNode)
    }
    func movePlayerCharacterTo(#deltaX: CGFloat, deltaY: CGFloat) {
        playerCharacterNode.position.x += deltaX
        playerCharacterNode.position.y += deltaY
    }
    func movePlayerCharacterToOneDirection(#deltaX: CGFloat, deltaY: CGFloat) {
        if abs(deltaX) > abs(deltaY) {
            movePlayerCharacterTo(deltaX: deltaX, deltaY: 0)
        } else {
            movePlayerCharacterTo(deltaX: 0, deltaY: deltaY)
        }
    }
    func getPlayerCharacterCenterPoint() -> CGPoint {
        return CGPoint(
            x: playerCharacterNode.position.x + playerCharacterNode.frame.width/2,
            y: playerCharacterNode.position.y + playerCharacterNode.frame.height/2)
    }
    
    // Setting methods
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}