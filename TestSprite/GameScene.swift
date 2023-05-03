//
//  GameScene.swift
//  TestSprite
//
//  YANG INDAH
//

import SpriteKit
import GameplayKit
import SwiftUI
import Dispatch
import UIKit

var cardArray = Card.cardData // inisiasi array
var playersDataArray = PlayersData.sampleData // inisiasi array
var buy : Bool = true

class MyObject {
    var objPosition: CGPoint = .zero
    
    func setPosition(position: CGPoint) {
        objPosition = position
        print("Objek diposisikan di \(objPosition)")
        print("update")
        print("update indah")
        print("update yuga")
    }
}

class Player {
    var name: String
    var pieceNode: SKSpriteNode
    var currentTileIndex: Int
    var currentPoin: Int
    
    init(name: String, pieceNode: SKSpriteNode, currentTileIndex: Int, currentPoin: Int) {
        self.name = name
        self.pieceNode = pieceNode
        self.currentTileIndex = currentTileIndex
        self.currentPoin = currentPoin
    }
}

class GameScene: SKScene {
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var boardNodes = [SKNode]()
    private var diceButton: SKSpriteNode?
    private var testDiceButton: SKSpriteNode?
    private var pieceNode: SKSpriteNode?
    public var diceNumber: Int = 1
    public var diceNumberFix: Int = 1
    public var coin: Int = 750
    
    //    public var players = [Player]()
    public var currentPlayerIndex = 0
    private var skip = 5
    public var skipCount = 2
    
    // NEW
    private var popUpContainer: SKSpriteNode?
    
    private var buttonLabel: SKLabelNode?
    private var buttonFrame: SKShapeNode?
    private var skipButtonLabel: SKLabelNode?
    private var skipButtonFrame: SKShapeNode?
    private var buyButtonLabel: SKLabelNode?
    private var buyButtonFrame: SKShapeNode?
    
    private var skView: SKView?
    
    let myObject = MyObject()
    private var countShown = 0
    private var buy = false
    private var userInfo: [String: Any]?
    private var userInfoBackup: [String: Any]?
    private var move: Int = 0
    
    private var textField: UITextField?
    private var textField2: UITextField?
    private var textField3: UITextField?
    
    //circles
    private var circleNode: SKShapeNode?
    private var circleNode2: SKShapeNode?
    private var circleNode3: SKShapeNode?
    private var circleNode4: SKShapeNode?
    private var circleNode5: SKShapeNode?
    
    private var firstCircleClicked = false
    private var secondCircleClicked = false
    private var thirdCircleClicked = false
    private var fourthCircleClicked = false
    private var fifthCircleClicked = false
    
    private var lieLabel: SKLabelNode?
    private var checkListLabel: SKLabelNode?
    private var selectedPrompt: String = "firstPrompt"
    
    override func didMove(to view: SKView) {
        //-----------------------------------BACKGROUND INITIATION--------------------------------------
        let background = SKSpriteNode(imageNamed: "mini2")
        background.position = CGPoint(x: 0, y: 0)
        background.size = self.size
        background.zPosition = -1
        addChild(background)
        
        let boardNode = SKNode()
        addChild(boardNode)
        
        let tileWidth: CGFloat = 50
        let tileHeight: CGFloat = 50
        let transparant = UIColor.red.withAlphaComponent(0)
        
        //------------------------------------BOARD CARD INITIATION--------------------------------------
        for _ in 0..<25 {
            let tileNode = SKSpriteNode(color: .black, size: CGSize(width: tileWidth, height: tileHeight))
            boardNode.addChild(tileNode)
            boardNodes.append(tileNode)
        }
        
        boardNodes[0].position = CGPoint(x: 130 , y: -10) //START
        boardNodes[1].position = CGPoint(x: 190 , y: -110) //HOME
//        250,150
        boardNodes[2].position = CGPoint(x: 280 , y: -170) //WY
        boardNodes[3].position = CGPoint(x: 380 , y: -180) //RandomCHallenge
        boardNodes[4].position = CGPoint(x: 450 , y: -120) //2T1L
        boardNodes[5].position = CGPoint(x: 470 , y: 0) // WY
        boardNodes[6].position = CGPoint(x: 420 , y: 80) //ToD
        boardNodes[7].position = CGPoint(x: 320 , y: 110) //RandomChallenge
        boardNodes[8].position = CGPoint(x: 210 , y: 60) //2T1L
        boardNodes[9].position = CGPoint(x: 60 , y: -130) //TOD
        boardNodes[10].position = CGPoint(x: -10 , y: -210) //WY
        boardNodes[11].position = CGPoint(x: -90 , y: -250) //RandomChallenge
        boardNodes[12].position = CGPoint(x: -180 , y: -270) //WY
        boardNodes[13].position = CGPoint(x: -270 , y: -240) //ToD
        boardNodes[14].position = CGPoint(x: -355 , y: -205) //ToD
        boardNodes[15].position = CGPoint(x: -425 , y: -135) //RandomChallenge
        boardNodes[16].position = CGPoint(x: -460 , y: -50) //ForceMove
        boardNodes[17].position = CGPoint(x: -470 , y: 40) //2T1l
        boardNodes[18].position = CGPoint(x: -425 , y: 135) //2T1L
        boardNodes[19].position = CGPoint(x: -360 , y: 200) //RandomChallenge
        boardNodes[20].position = CGPoint(x: -270 , y: 240) //WY
        boardNodes[21].position = CGPoint(x: -170 , y: 260) //2T1L
        boardNodes[22].position = CGPoint(x: -80 , y: 240) //ToD
        boardNodes[23].position = CGPoint(x: 10 , y: 180) //RandomChallenge
        boardNodes[24].position = CGPoint(x: 70 , y: 90) //LetGo
        
        let startingBoardNode = boardNodes[0] // assuming you have an array of board nodes
        
        //--------------------------------------PLAYERS INITIATION------------------------------------------
        for player in 0..<playersDataArray.count {
            let startingBoardNode = boardNodes[playersDataArray[player].currentSteps]
            playersDataArray[player].pieceNode.position = startingBoardNode.position
            playersDataArray[player].pieceNode.isUserInteractionEnabled = true
            playersDataArray[player].pieceNode.name = "gamePiece"
            boardNode.addChild(playersDataArray[player].pieceNode)
        }
        
        // ------------------------------------DICE INITIATION----------------------------------------------
        var diceButtonTexture = SKTexture(imageNamed: "dice\(diceNumber)")
        diceButton = SKSpriteNode(texture: diceButtonTexture)
        diceButton?.size = CGSize(width: 200, height: 200)
        diceButton?.position = CGPoint(x: -180, y: 0)
        addChild(diceButton!)
        
        // ------------------------------------POP UP CONTAINER----------------------------------------------
        // ada method sendiri di bawah
        
        // ------------------------------------TEXT FIELDCONTAINER-------------------------------------------
        
    }
    
    // --------------------------------FUNC TO MOVE OBJECT--------------------------------------------------
    func movePiece(_ pieceNode: SKSpriteNode, toTile tileNode: Int) {
        // Calculate the position of the center of the tile node
        let targetPosition = boardNodes[tileNode].position
        
        // Calculate the duration of the movement based on the distance
        let dx = targetPosition.x - pieceNode.position.x
        let dy = targetPosition.y - pieceNode.position.y
        let distance = sqrt(dx*dx + dy*dy)
        let duration = TimeInterval(distance / 400.0) // adjust 100.0 as needed
        
        // Create an SKAction to move the piece to the target position
        let moveAction = SKAction.move(to: targetPosition, duration: duration)
        
        // Run the move action on the piece node
        pieceNode.run(moveAction)
        myObject.setPosition(position: targetPosition)
        // Thread.sleep(forTimeInterval: 1)
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if diceButton?.contains(touchLocation) == true {
            var currentPlayer = playersDataArray[currentPlayerIndex]
            // print(currentPlayer)
            
            let diceNumber = rollDice()
            let diceButtonTexture = SKTexture(imageNamed: "dice\(diceNumber)")
            diceButton?.texture = diceButtonTexture
            var count = 0
            var count2 = 0
            
            let diceRollTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { [weak self] timer in
                count += 1
                if count == 7 {
                    timer.invalidate()
                    return
                }
                let diceNumber = self?.rollDice() ?? 1
                let diceButtonTexture = SKTexture(imageNamed: "dice\(diceNumber)")
                self?.diceButton?.run(SKAction.setTexture(diceButtonTexture), completion: { [self] in
                    if count == 6 {
                        self!.diceNumberFix = diceNumber
                        var move = playersDataArray[self!.currentPlayerIndex].currentSteps + self!.diceNumberFix//
                        playersDataArray[self!.currentPlayerIndex].currentSteps = move
                        
                        if move >= 25 {
                            move = move - 25
                            currentPlayer.currentPoin = currentPlayer.currentPoin + 150
                        }
                        self!.movePiece(currentPlayer.pieceNode, toTile: move)
                        //                         if cardArray[move].cardChallengesType == "SafeHouse" {
                        //                             self!.skipCount -= 1
                        //                             if self!.skipCount != 0 {
                        //                                 self!.movePiece(currentPlayer.pieceNode, toTile: move)
                        //                             }
                        //                             else {
                        //                                 print("berhasil kelewat")
                        //                             }
                        //
                        //                         }
                        //                         else {
                        //                             self!.movePiece(currentPlayer.pieceNode, toTile: move)
                        //                         }
                        
                        currentPlayer.currentPoin = self!.gameRules(move: move, coin: currentPlayer.currentPoin, player: currentPlayer.playersName)
                        print("namanya: \(currentPlayer.playersName), dan poinnya: \(currentPlayer.currentPoin)")
                        
                        self!.currentPlayerIndex += 1
                        if self!.currentPlayerIndex >= playersDataArray.count {
                            self!.currentPlayerIndex = 0
                        }
                        self?.countShown = 0
                    }
                })
            }
            
            let popUpTimer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { [weak self] timer in
                if count == 7 {
                    count2 += 1
                    if count2 == 3 {
                        self?.addChallengePopUp()
                        timer.invalidate()
                        return
                    }
                }
            }
            
        } else if buttonFrame?.contains(touchLocation) == true {
            popUpContainer?.removeFromParent()
            skView?.removeFromSuperview()
            
            let firstPrompt = textField?.text
            self.userInfo = ["FirstPrompt": firstPrompt ?? ""]
            self.userInfoBackup = self.userInfo
            cardArray[self.move].firstPrompt = self.userInfoBackup?["FirstPrompt"] as! String
            self.countShown = 2
            
            let secondPrompt = textField2?.text
            self.userInfo = ["SecondPrompt": secondPrompt ?? ""]
            self.userInfoBackup = self.userInfo
            cardArray[self.move].secondPrompt = self.userInfoBackup?["SecondPrompt"] as! String
            self.countShown = 2
            
            let thirdPrompt = textField3?.text
            self.userInfo = ["ThirdPrompt": thirdPrompt ?? ""]
            self.userInfoBackup = self.userInfo
            cardArray[self.move].thirdPrompt = self.userInfoBackup?["ThirdPrompt"] as! String
            self.countShown = 2
            
            cardArray[self.move].correctPrompt = self.selectedPrompt
            
            print(cardArray[self.move].firstPrompt)
            print(cardArray[self.move].secondPrompt)
            print(cardArray[self.move].thirdPrompt)
            
            print(selectedPrompt)
            print(cardArray[self.move].correctPrompt)
            
        } else if circleNode?.contains(touchLocation) == true {
            firstCircleClicked.toggle()
            selectedPrompt = "firstPrompt"
            
            //check list label on circle
            checkListLabel = SKLabelNode(text: "✓")
            checkListLabel?.fontName = "AvenirNext-Bold"
            checkListLabel?.fontColor = .white
            checkListLabel?.fontSize = 50
            checkListLabel?.position = CGPoint(x: 0, y: -17)
            
            checkListLabel?.removeFromParent()
            circleNode?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode?.addChild(checkListLabel!)
            
            circleNode2?.fillColor = UIColor.white
            secondCircleClicked = false
            
        } else if circleNode2?.contains(touchLocation) == true {
            secondCircleClicked.toggle()
            selectedPrompt = "secondPrompt"
            
            //check list label on circle
            checkListLabel = SKLabelNode(text: "✓")
            checkListLabel?.fontName = "AvenirNext-Bold"
            checkListLabel?.fontColor = .white
            checkListLabel?.fontSize = 50
            checkListLabel?.position = CGPoint(x: 0, y: -17)
            
            checkListLabel?.removeFromParent()
            circleNode2?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode2?.addChild(checkListLabel!)
            
            circleNode?.fillColor = UIColor.white
            firstCircleClicked = false
            
        } else if circleNode3?.contains(touchLocation) == true {
            thirdCircleClicked.toggle()
            selectedPrompt = "firstPrompt"
            
            //check list label on circle
            lieLabel = SKLabelNode(text: "LIE")
            lieLabel?.fontName = "AvenirNext-Bold"
            lieLabel?.fontColor = .white
            lieLabel?.fontSize = 30
            lieLabel?.position = CGPoint(x: 0, y: -10)
            
            lieLabel?.removeFromParent()
            circleNode3?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode3?.addChild(lieLabel!)
            
            circleNode4?.fillColor = UIColor.white
            circleNode5?.fillColor = UIColor.white
            
            fourthCircleClicked = false
            fifthCircleClicked = false
            
        } else if circleNode4?.contains(touchLocation) == true {
            fourthCircleClicked.toggle()
            selectedPrompt = "secondPrompt"
            
            //check list label on circle
            lieLabel = SKLabelNode(text: "LIE")
            lieLabel?.fontName = "AvenirNext-Bold"
            lieLabel?.fontColor = .white
            lieLabel?.fontSize = 30
            lieLabel?.position = CGPoint(x: 0, y: -10)
            
            lieLabel?.removeFromParent()
            circleNode4?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode4?.addChild(lieLabel!)
            
            circleNode3?.fillColor = UIColor.white
            circleNode5?.fillColor = UIColor.white
            
            thirdCircleClicked = false
            fifthCircleClicked = false
            
        } else if circleNode5?.contains(touchLocation) == true {
            fifthCircleClicked.toggle()
            selectedPrompt = "thirdPrompt"
            
            //check list label on circle
            lieLabel = SKLabelNode(text: "LIE")
            lieLabel?.fontName = "AvenirNext-Bold"
            lieLabel?.fontColor = .white
            lieLabel?.fontSize = 30
            lieLabel?.position = CGPoint(x: 0, y: -10)
            
            lieLabel?.removeFromParent()
            circleNode5?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
            circleNode5?.addChild(lieLabel!)
            
            circleNode3?.fillColor = UIColor.white
            circleNode4?.fillColor = UIColor.white
            
            thirdCircleClicked = false
            fourthCircleClicked = false
            
        }
        
    }
    
    func addPopUpContainer() {
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 600))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: "2 TRUTH 1 LIE")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 220)
        
        //next button
        buttonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        buttonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buttonFrame?.position = CGPoint(x: 0, y: -220)
        
        buttonLabel = SKLabelNode(text: "NEXT")
        buttonLabel?.fontName = "AvenirNext-Bold"
        buttonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buttonLabel?.fontSize = 50
        buttonLabel?.position = CGPoint(x: 0, y: -19)
        
        //first text field
        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 600, height: 70))
        textField = UITextField(frame: textFieldFrame)
        textField?.backgroundColor = UIColor.white
        textField?.placeholder = "Enter your prompt"
        textField?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField?.leftView = leftPaddingView
        textField?.leftViewMode = .always
        
        circleNode3 = SKShapeNode(circleOfRadius: 40)
        circleNode3?.fillColor = UIColor.white
        circleNode3?.lineWidth = 2
        circleNode3?.position = CGPoint(x: -370, y: 132)
        
        //second text field
        let textField2Frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 600, height: 70))
        textField2 = UITextField(frame: textField2Frame)
        textField2?.backgroundColor = UIColor.white
        textField2?.placeholder = "Enter your prompt"
        textField2?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPadding2View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField2?.leftView = leftPadding2View
        textField2?.leftViewMode = .always
        
        circleNode4 = SKShapeNode(circleOfRadius: 40)
        circleNode4?.fillColor = UIColor.white
        circleNode4?.lineWidth = 2
        circleNode4?.position = CGPoint(x: -370, y: 15)
        
        //third text field
        let textField3Frame = CGRect(origin: CGPoint(x: 0, y: 200), size: CGSize(width: 600, height: 70))
        textField3 = UITextField(frame: textField3Frame)
        textField3?.backgroundColor = UIColor.white
        textField3?.placeholder = "Enter your prompt"
        textField3?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPadding3View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField3?.leftView = leftPadding3View
        textField3?.leftViewMode = .always
        
        circleNode5 = SKShapeNode(circleOfRadius: 40)
        circleNode5?.fillColor = UIColor.white
        circleNode5?.lineWidth = 2
        circleNode5?.position = CGPoint(x: -370, y: -103)
        
        //frame for text field
        let sceneFrame = CGRect(origin: .zero, size: CGSize(width: 520, height: 300))
        let scene = SKScene(size: sceneFrame.size)
        scene.backgroundColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        scene.view?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        skView = SKView(frame: sceneFrame)
        skView?.addSubview(textField!)
        skView?.addSubview(textField2!)
        skView?.addSubview(textField3!)
        skView?.presentScene(scene)
        
        if let view = self.view {
            skView?.center = view.center
            view.addSubview(skView!)
            popUpContainer?.inputView?.addSubview(skView!)
        }
        
        addChild(popUpContainer!)
        buttonFrame?.addChild(buttonLabel!)
        popUpContainer?.addChild(buttonFrame!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(circleNode3!)
        popUpContainer?.addChild(circleNode4!)
        popUpContainer?.addChild(circleNode5!)
    }
    
    func addPopUpContainer2() {
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 480))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: "WOULD YOU RATHER")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 160)
        
        //next button
        buttonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        buttonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buttonFrame?.position = CGPoint(x: 0, y: -160)
        
        buttonLabel = SKLabelNode(text: "NEXT")
        buttonLabel?.fontName = "AvenirNext-Bold"
        buttonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buttonLabel?.fontSize = 50
        buttonLabel?.position = CGPoint(x: 0, y: -177)
        
        //first text field
        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 600, height: 70))
        textField = UITextField(frame: textFieldFrame)
        textField?.backgroundColor = UIColor.white
        textField?.placeholder = "Enter your prompt"
        textField?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField?.leftView = leftPaddingView
        textField?.leftViewMode = .always
        
        circleNode = SKShapeNode(circleOfRadius: 40)
        circleNode?.fillColor = UIColor.white
        circleNode?.lineWidth = 2
        circleNode?.position = CGPoint(x: -370, y: 75)
        
        //second text field
        let textField2Frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 600, height: 70))
        textField2 = UITextField(frame: textField2Frame)
        textField2?.backgroundColor = UIColor.white
        textField2?.placeholder = "Enter your prompt"
        textField2?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPadding2View = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField2?.leftView = leftPadding2View
        textField2?.leftViewMode = .always
        
        circleNode2 = SKShapeNode(circleOfRadius: 40)
        circleNode2?.fillColor = UIColor.white
        circleNode2?.lineWidth = 2
        circleNode2?.position = CGPoint(x: -370, y: -40)
        
        //frame for text field
        let sceneFrame = CGRect(origin: .zero, size: CGSize(width: 520, height: 200))
        let scene = SKScene(size: sceneFrame.size)
        scene.backgroundColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        scene.view?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        skView = SKView(frame: sceneFrame)
        skView?.addSubview(textField!)
        skView?.addSubview(textField2!)
        skView?.presentScene(scene)
        
        if let view = self.view {
            skView?.center = view.center
            view.addSubview(skView!)
            popUpContainer?.inputView?.addSubview(skView!)
        }
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(buttonFrame!)
        popUpContainer?.addChild(buttonLabel!)
        popUpContainer?.addChild(circleNode!)
        popUpContainer?.addChild(circleNode2!)
    }
    
    func addPopUpContainer3() {
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 380))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: "TRUTH OR DARE")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 100)
        
        //next button
        buttonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        buttonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buttonFrame?.position = CGPoint(x: 0, y: -115)
        
        buttonLabel = SKLabelNode(text: "NEXT")
        buttonLabel?.fontName = "AvenirNext-Bold"
        buttonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buttonLabel?.fontSize = 50
        buttonLabel?.position = CGPoint(x: 0, y: -135)
        
        //first text field
        let textFieldFrame = CGRect(origin: CGPoint(x: 0, y: -11), size: CGSize(width: 600, height: 70))
        textField = UITextField(frame: textFieldFrame)
        textField?.backgroundColor = UIColor.white
        textField?.placeholder = "Enter your prompt"
        textField?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldFrame.size.height))
        textField?.leftView = leftPaddingView
        textField?.leftViewMode = .always
        
        //frame for text field
        let sceneFrame = CGRect(origin: .zero, size: CGSize(width: 600, height: 70))
        let scene = SKScene(size: sceneFrame.size)
        scene.backgroundColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        scene.view?.layer.cornerRadius = textFieldFrame.size.height / 2
        
        skView = SKView(frame: sceneFrame)
        skView?.addSubview(textField!)
        skView?.presentScene(scene)
        
        if let view = self.view {
            skView?.center = view.center
            view.addSubview(skView!)
            popUpContainer?.inputView?.addSubview(skView!)
        }
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(buttonLabel!)
        popUpContainer?.addChild(buttonFrame!)
    }
    
    func addBuyOfferPopUp() {
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 350))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: "YOU LANDED ON")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 80)
        
        let challengeNameLabel = SKLabelNode(text: "Would You Rather")
        challengeNameLabel.fontName = "AvenirNext-Bold"
        challengeNameLabel.fontColor = UIColor(red: 53/255, green: 157/255, blue: 158/255, alpha: 100)
        challengeNameLabel.fontSize = 55
        challengeNameLabel.position = CGPoint(x: 0, y: 10)
        
        //skip button
        skipButtonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        skipButtonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        skipButtonFrame?.position = CGPoint(x: 210, y: -82)
        
        skipButtonLabel = SKLabelNode(text: "SKIP")
        skipButtonLabel?.fontName = "AvenirNext-Bold"
        skipButtonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        skipButtonLabel?.fontSize = 50
        skipButtonLabel?.position = CGPoint(x: 210, y: -100)
        
        //buy button
        buyButtonFrame = SKShapeNode(rectOf: CGSize(width: 365, height: 85), cornerRadius: 40)
        buyButtonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buyButtonFrame?.position = CGPoint(x: -160, y: -82)
        
        buyButtonLabel = SKLabelNode(text: "BUY      180")
        buyButtonLabel?.fontName = "AvenirNext-Bold"
        buyButtonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buyButtonLabel?.fontSize = 50
        buyButtonLabel?.position = CGPoint(x: -160, y: -100)
        
        //coin image for button
        let coinImage = SKSpriteNode(imageNamed: "coin")
        coinImage.position = CGPoint(x: -157, y: -80)
        coinImage.size = CGSize(width: 50, height: 50)
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(challengeNameLabel)
        popUpContainer?.addChild(buyButtonLabel!)
        popUpContainer?.addChild(buyButtonFrame!)
        popUpContainer?.addChild(skipButtonLabel!)
        popUpContainer?.addChild(skipButtonFrame!)
        popUpContainer?.addChild(coinImage)
    }
    
    func addChallengePopUp() {
        popUpContainer = SKSpriteNode(color: UIColor(red: 1, green: 1, blue: 1, alpha: 0), size: CGSize(width: 1000, height: 350))
        popUpContainer?.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        popUpContainer?.zPosition = 1
        
        //background for popUpContainer
        let cornerRadius = CGFloat(50)
        let roundedRect = CGRect(x: -popUpContainer!.size.width / 2, y: -popUpContainer!.size.height / 2, width: popUpContainer!.size.width, height: popUpContainer!.size.height)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: cornerRadius)
        let shape = SKShapeNode(path: path.cgPath)
        shape.fillColor = UIColor(red: 203/255, green: 218/255, blue: 224/255, alpha: 100)
        popUpContainer?.addChild(shape)
        
        //title
        let titleLabel = SKLabelNode(text: "CHALLENGE")
        titleLabel.fontName = "AvenirNext-Bold"
        titleLabel.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        titleLabel.fontSize = 55
        titleLabel.position = CGPoint(x: 0, y: 100)
        
        //challenge label
        let challengeNameLabel = SKLabelNode(text: "What is the one thing that you have always wanted to do but have been too afraid to try?")
        challengeNameLabel.fontName = "AvenirNext"
        challengeNameLabel.fontColor = UIColor.black
        challengeNameLabel.fontSize = 25
        challengeNameLabel.position = CGPoint(x: 0, y: 10)
        challengeNameLabel.numberOfLines = 2
        
        //next button
        buttonFrame = SKShapeNode(rectOf: CGSize(width: 300, height: 85), cornerRadius: 40)
        buttonFrame?.fillColor = UIColor(red: 85/255, green: 197/255, blue: 149/255, alpha: 100)
        buttonFrame?.position = CGPoint(x: 0, y: -105)
        
        buttonLabel = SKLabelNode(text: "DONE")
        buttonLabel?.fontName = "AvenirNext-Bold"
        buttonLabel?.fontColor = UIColor(red: 33/255, green: 82/255, blue: 115/255, alpha: 100)
        buttonLabel?.fontSize = 50
        buttonLabel?.position = CGPoint(x: 0, y: -125)
        
        addChild(popUpContainer!)
        popUpContainer?.addChild(titleLabel)
        popUpContainer?.addChild(challengeNameLabel)
        popUpContainer?.addChild(buttonLabel!)
        popUpContainer?.addChild(buttonFrame!)
    }
    
    override func didEvaluateActions() {
        var objPosition = myObject.objPosition
        if ((objPosition.x == 510 && objPosition.y == 120) || (objPosition.x == 70 && objPosition.y == -150)) && countShown == 0 {
            let alertController = UIAlertController(title: "Konfirmasi", message: "Do you want to buy this card?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { [weak self] (_) in
                self?.buy = true
                self?.addPopUpContainer()
            }
            
            let noAction = UIAlertAction(title: "No", style: .cancel) { [weak self] (_) in
                self?.buy = false
                //                self?.countShown = 1
            }
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            view?.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            countShown = 1
        }
    }
    
    func rollDice() -> Int {
        return Int.random(in: 1...6)
    }
    
    func delay(_ seconds: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            closure()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    func gameRules(move: Int, coin: Int, player: String) -> Int {
        
        var coinz = coin
        //        if cardArray[move].cardChallengesType == "SafeHouse" {
        //            print("which card that you want to let go?")
        //            let userInput = readLine()
        //            print("card \(userInput ?? "nil") is no longer be yours")
        //        }
        
        if cardArray[move].cardOwner == "Null" {
            if cardArray[move].cardChallengesType == "2T1l" {
                if coinz >= 150 {
                    coinz -= 150
                    cardArray[move].cardOwner = player
                }
                else {
                    print("gapunya duit")
                }
            }
            else if cardArray[move].cardChallengesType == "TOD" {
                if coinz >= 180 {
                    coinz -= 180
                    cardArray[move].cardOwner = player
                }
                else {
                    print("gapunya duit")
                }
            }
            else if cardArray[move].cardChallengesType == "WY" {
                if coinz >= 120 {
                    coinz -= 120
                    cardArray[move].cardOwner = player
                }
                else {
                    print("gapunya duit")
                }
            }
            else if cardArray[move].cardChallengesType == "Challenge" { //harus dicheck dulu bisa nyelesain challenge apa engga
                coinz += 50
            }
        }
        else {
            if cardArray[move].cardChallengesType == "2T1l" {
                if buy == true {
                    if coinz >= 200 {
                        coinz -= 200
                        cardArray[move].cardOwner = player
                    }
                    else {
                        print("gapunya duit")
                    }
                }
                else {
                    if coinz >= 150 {
                        coinz -= 150
                    }
                    else {
                        print("gapunya duit")
                    }
                }
            }
            else if cardArray[move].cardChallengesType == "TOD" {
                if buy == true {
                    if coinz >= 230 {
                        coinz -= 230
                        cardArray[move].cardOwner = player
                    }
                    else {
                        print("gapunya duit")
                    }
                }
                else {
                    if coinz >= 180 {
                        coinz -= 180
                    }
                    else {
                        print("gapunya duit")
                    }
                }
            }
            else if cardArray[move].cardChallengesType == "WY" {
                if buy == true {
                    if coinz >= 180 {
                        coinz -= 180
                        cardArray[move].cardOwner = player
                    }
                    else {
                        print("gapunya duit")
                    }
                }
                else {
                    if coinz >= 120 {
                        coinz -= 120
                    }
                    else {
                        print("gapunya duit")
                    }
                }
            }
        }
        
        print("pemilik = \(cardArray[move].cardOwner)")
        
        return coinz
    }
}


//----------------------------------------------------------------------------------

