//
//  GameViewController.swift
//  TestSprite
//
//  Created by I MADE DWI MAHARDIKA on 21/04/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true

            // Create a new UIView for the player info
            var playerInfoView1 = UIView(frame: CGRect(x: 15, y: 13, width: 348, height: 150))
            var playerInfoView2 = UIView(frame: CGRect(x: 831, y: 13, width: 348, height: 150))
            var playerInfoView3 = UIView(frame: CGRect(x: 831, y: 666, width: 348, height: 150))
            var playerInfoView4 = UIView(frame: CGRect(x: 15, y: 666, width: 348, height: 150))
            
            let playerInfoView1Background = UIImageView(frame: CGRect(x: 15, y: 14, width: 348, height: 150))
            playerInfoView1Background.image = UIImage(named: "background_player_info")
            
            let playerInfoView2Background = UIImageView(frame: CGRect(x: 831, y: 13, width: 348, height: 150))
            playerInfoView1Background.image = UIImage(named: "background_player_info")
        
            let playerInfoView3Background = UIImageView(frame: CGRect(x: 831, y: 666, width: 348, height: 150))
            playerInfoView1Background.image = UIImage(named: "background_player_info")
            
            let playerInfoView4Background = UIImageView(frame: CGRect(x: 15, y: 656, width: 348, height: 150))
            playerInfoView1Background.image = UIImage(named: "background_player_info")
            
            // Set the background color of the view
            playerInfoView1.backgroundColor = UIColor(.red)
            
            // Create an UIImageView for the player avatar
            let avatarImageView1 = UIImageView(frame: CGRect(x: 44, y: 41, width: 82, height: 97))
            let avatarImageView2 = UIImageView(frame: CGRect(x: 44, y: 41, width: 82, height: 97))
            let avatarImageView3 = UIImageView(frame: CGRect(x: 44, y: 41, width: 82, height: 97))
            let avatarImageView4 = UIImageView(frame: CGRect(x: 44, y: 41, width: 82, height: 97))
            
            // Set the image for the avatar
            avatarImageView1.image = UIImage(named: "playerfix1")
            avatarImageView2.image = UIImage(named: "playerfix2")
            avatarImageView3.image = UIImage(named: "playerfix3")
            avatarImageView4.image = UIImage(named: "playerfix4")
            
            
            // Add the avatar image view to the player info view
            
            
            
            
            // Create an UILabel for the player score
            let scoreLabel1 = UILabel(frame: CGRect(x: 202, y: 99, width: 52, height: 22))
            let scoreLabel2 = UILabel(frame: CGRect(x: 202, y: 99, width: 52, height: 22))
            let scoreLabel3 = UILabel(frame: CGRect(x: 202, y: 99, width: 52, height: 22))
            let scoreLabel4 = UILabel(frame: CGRect(x: 202, y: 99, width: 52, height: 22))
            
            let playerlabel1 = UILabel(frame: CGRect(x: 149, y: 50, width: 144, height: 25))
            let playerlabel2 = UILabel(frame: CGRect(x: 149, y: 50, width: 144, height: 25))
            let playerlabel3 = UILabel(frame: CGRect(x: 149, y: 50, width: 144, height: 25))
            let playerlabel4 = UILabel(frame: CGRect(x: 149, y: 50, width: 144, height: 25))
            
            
            
            let coinImageView1 = UIImageView(frame: CGRect(x: 144, y: 86, width: 51, height: 46))
            coinImageView1.image = UIImage(named: "coin")
            
            let coinImageView2 = UIImageView(frame: CGRect(x: 144, y: 86, width: 51, height: 46))
            coinImageView2.image = UIImage(named: "coin")
            
            let coinImageView3 = UIImageView(frame: CGRect(x: 144, y: 86, width: 51, height: 46))
            coinImageView3.image = UIImage(named: "coin")
            
            let coinImageView4 = UIImageView(frame: CGRect(x: 156, y: 732, width: 51, height: 46))
            coinImageView4.image = UIImage(named: "coin")
            
            // Set the text for the score label
            playerlabel1.text = "PLAYER 1"
            playerlabel2.text = "PLAYER 2"
            playerlabel3.text = "PLAYER 3"
            playerlabel4.text = "PLAYER 4"
//            scoreLabel1.text = String(playersDataArray[0].currentPoin)
            
            // Set the font and text color for the score label
            scoreLabel1.font = UIFont.systemFont(ofSize: 24)
            scoreLabel1.textColor = UIColor(hex: 0x215172)
            
            scoreLabel2.font = UIFont.systemFont(ofSize: 24)
            scoreLabel2.textColor = UIColor(hex: 0x215172)
            
            scoreLabel3.font = UIFont.systemFont(ofSize: 24)
            scoreLabel3.textColor = UIColor(hex: 0x215172)
            
            scoreLabel4.font = UIFont.systemFont(ofSize: 24)
            scoreLabel4.textColor = UIColor(hex: 0x215172)
            
            playerlabel1.font = UIFont.systemFont(ofSize: 32)
            playerlabel1.textColor = UIColor(hex: 0x215172)
            
            playerlabel2.font = UIFont.systemFont(ofSize: 32)
            playerlabel2.textColor = UIColor(hex: 0x215172)
            
            playerlabel3.font = UIFont.systemFont(ofSize: 32)
            playerlabel3.textColor = UIColor(hex: 0x215172)
            
            playerlabel4.font = UIFont.systemFont(ofSize: 32)
            playerlabel4.textColor = UIColor(hex: 0x215172)
            
            scoreLabel1.text = "\(playersDataArray[0].currentPoin)"
            scoreLabel2.text = "\(playersDataArray[1].currentPoin)"
            scoreLabel3.text = "\(playersDataArray[2].currentPoin)"
            scoreLabel4.text = "\(playersDataArray[3].currentPoin)"

            
            
            
            // Add the score label to the player info view
            playerInfoView1.addSubview(scoreLabel1)
            playerInfoView1.addSubview(coinImageView1)
            playerInfoView1.addSubview(playerlabel1)
            playerInfoView1.addSubview(playerInfoView1Background)
            playerInfoView1.addSubview(avatarImageView1)
            
            playerInfoView2.addSubview(scoreLabel2)
            playerInfoView2.addSubview(coinImageView2)
            playerInfoView2.addSubview(playerlabel2)
            playerInfoView2.addSubview(playerInfoView2Background)
            playerInfoView2.addSubview(avatarImageView2)
            
            playerInfoView3.addSubview(scoreLabel3)
            playerInfoView3.addSubview(coinImageView3)
            playerInfoView3.addSubview(playerlabel3)
            playerInfoView3.addSubview(playerInfoView3Background)
            playerInfoView3.addSubview(avatarImageView3)
            
            playerInfoView4.addSubview(scoreLabel4)
            playerInfoView4.addSubview(coinImageView4)
            playerInfoView4.addSubview(playerlabel4)
            playerInfoView4.addSubview(playerInfoView4Background)
            playerInfoView4.addSubview(avatarImageView4)

            // Add the player info view to the main view
            view.addSubview(playerInfoView1)
            view.addSubview(playerInfoView2)
            view.addSubview(playerInfoView3)
            view.addSubview(playerInfoView4)
            
            // Position the player info view to the top left corner of the screen
            playerInfoView1.translatesAutoresizingMaskIntoConstraints = false
            playerInfoView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            playerInfoView1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            
//            playerInfoView2.translatesAutoresizingMaskIntoConstraints = false
//            playerInfoView2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//            playerInfoView2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
//            
//            playerInfoView3.translatesAutoresizingMaskIntoConstraints = false
//            playerInfoView3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//            playerInfoView3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//            
//            playerInfoView4.translatesAutoresizingMaskIntoConstraints = false
//            playerInfoView4.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//            playerInfoView4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//            
//            if let gameScene = view.scene as? GameScene {
//                if let playerInfoView1 = view.subviews.first(where: { $0 is UIView }) {
//                    if let scoreLabel1 = playerInfoView1.subviews.first(where: { $0 is UILabel }) as? UILabel {
//                        scoreLabel1.text = "\(playersDataArray[0].currentPoin)"
//                    }
//                }
//            }
            
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
