//
//  WindowController.swift
//  Pikachu-Bar-Runner
//
//  Created by Pierre on 22/12/2016.
//  Copyright © 2016 Pierre BOUDON. All rights reserved.
//

import Cocoa
import SpriteKit
import AVFoundation

class WindowController: NSWindowController {
    
    // MARK: - Variables
    var score: Int = 0
    var gameScene = GameScene()
    var audioPlayer: AVAudioPlayer?

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Add observers to NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(WindowController.updateScore), name: StaticDataProviders.scoreNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WindowController.changeToPlayButton), name: StaticDataProviders.playButtonNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WindowController.changeToPauseButton), name: StaticDataProviders.pauseButtonNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WindowController.changeToReplayButton), name: StaticDataProviders.replayButtonNotification, object: nil)
        
        // Setup audio player
        self.setupAudioPlayer()
    }

}

// MARK: - Extension for Setup methods
extension WindowController {
    public func setupAudioPlayer() {
        let path = Bundle.main.path(forResource: "Pikachu1", ofType: "mp3")
        let file = URL(fileURLWithPath: path!)
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: file)
            self.audioPlayer?.delegate = self
            self.audioPlayer?.prepareToPlay()
            self.audioPlayer?.play()
        } catch {
            print("Impossible de créer le player audio.")
        }
    }
}

// MARK: - Extension for TouchBar
@available(OSX 10.12.2, *)
extension WindowController {
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .customTouchBar
        touchBar.defaultItemIdentifiers = [.playButton, .label, .scoreLabel, .customView]
        touchBar.customizationAllowedItemIdentifiers = [.customView]
        
        return touchBar
    }
    
    public func replay() {
        let item = self.touchBar?.item(forIdentifier: .customView)
        
        if let view: SKView = item?.view as? SKView {
            self.gameScene = GameScene()
            view.presentScene(self.gameScene)

            self.gameScene.play()
            self.score = -1
            
            self.updateScore()
            self.changeToPauseButton()
        }
    }
}

// MARK: - Extension for TouchBar Delegate
@available(OSX 10.12.2, *)
extension WindowController: NSTouchBarDelegate {
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItemIdentifier) -> NSTouchBarItem? {
        switch identifier {
        case NSTouchBarItemIdentifier.playButton:
            let item = NSCustomTouchBarItem(identifier: identifier)
            let button = NSButton(title: "Play", target: self.gameScene, action: #selector(GameScene.play))
            button.bezelColor = NSColor.PikaGreen
            item.view = button
            
            return item
            
        case NSTouchBarItemIdentifier.label:
            let item = NSCustomTouchBarItem(identifier: identifier)
            item.view = NSTextField(labelWithString: "Score :")
            
            return item
            
        case NSTouchBarItemIdentifier.scoreLabel:
            let item = NSCustomTouchBarItem(identifier: identifier)
            item.view = NSTextField(labelWithString: "----")
            
            return item
            
        case NSTouchBarItemIdentifier.customView:
            let gameView = SKView()
            let item = NSCustomTouchBarItem(identifier: identifier)
            item.view = gameView
            gameView.presentScene(self.gameScene)
            
            return item
            
        default:
            return nil
        }
    }
}

// MARK: - Extension for NotificationCenter methods
extension WindowController {
    public func updateScore() {
        if #available(OSX 10.12.2, *) {
            let item = self.touchBar?.item(forIdentifier: .scoreLabel)
            
            if let view: NSTextField = item?.view as? NSTextField {
                self.score += 1
                view.stringValue = "\(self.score)"
            }
        } else {
            
        }
    }
    
    public func changeToPlayButton() {
        if #available(OSX 10.12.2, *) {
            let item = self.touchBar?.item(forIdentifier: .playButton)
            
            if let view: NSButton = item?.view as? NSButton {
                view.title = "Play"
                view.bezelColor = NSColor.PikaGreen
                view.target = self.gameScene
                view.action = #selector(GameScene.play)
            }
        } else {
            
        }
    }
    
    public func changeToPauseButton() {
        if #available(OSX 10.12.2, *) {
            let item = self.touchBar?.item(forIdentifier: .playButton)
            
            if let view: NSButton = item?.view as? NSButton {
                view.title = "Pause"
                view.bezelColor = NSColor.PikaBlue
                view.target = self.gameScene
                view.action = #selector(GameScene.pause)
            }
        } else {
            
        }
    }
    
    public func changeToReplayButton() {
        if #available(OSX 10.12.2, *) {
            let item = self.touchBar?.item(forIdentifier: .playButton)
            
            if let view: NSButton = item?.view as? NSButton {
                view.title = "Replay"
                view.bezelColor = NSColor.PikaGreen
                view.target = self
                view.action = #selector(WindowController.replay)
            }
        } else {
            
        }
    }
}

// MARK: - Extension for AVAudioPlayer Delegate
extension WindowController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let path = Bundle.main.path(forResource: "Pikachu2", ofType: "mp3")
        let file = URL(fileURLWithPath: path!)
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: file)
            self.audioPlayer?.delegate = self
            self.audioPlayer?.prepareToPlay()
            self.audioPlayer?.play()
        } catch {
            print("Impossible de créer le player audio.")
        }
    }
}
