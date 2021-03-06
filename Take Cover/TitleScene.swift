//
//  TitleScene.swift
//  Take Cover
//
//  Created by Alexander Warren on 4/9/16.
//  Copyright © 2016 Alexander Warren. All rights reserved.
//

import SpriteKit
import AVFoundation

struct Cloud {
    static var playerString = "default"
    static var currency = 0
    static var lockedForPlayers = [
        false,
        true,
        true,
        true,
        true,
        true,
        true
    ]
    static var lockedForThemes = [
        false,
        true,
        true
    ]
    static var sound = true
    static var themeString = "classic"
    static var backFromSettings = false
    static var backFromShop = false
    static var model = String()
    static var highScore = 0
    static var showTutorial = true
    static var color = ""
    static var canAskForRating = true
    static var gameCounter = 0
    static var gameIsOpened = false
}

struct DefaultsKeys {
    static let currencyKey = "currencyKey"
    static let lockedForPlayersKey = "lockedForPlayersKey"
    static let lockedForThemesKey = "lockedForThemesKey"
    static let playerStringKey = "playerStringKey"
    static let themeStringKey = "themeStringKey"
    static let highScoreKey = "highScoreKey"
    static let musicKey = "musicKey"
    static let showTutorialKey = "showTutorialKey"
    static let colorKey = "colorKey"
    static let askForRatingKey = "askForRatingKey"
    static let gameCounterKey = "gameCounterKey"
}

class TitleScene: SKScene {
    
    var titleImg = UIImageView()
    var playButton = UIButton()
    var shopButton = UIButton()
    let settingsButton = UIButton()
    let currencyLabel = UILabel()
    var cornerImages = [UIImageView]()
    let cornerImageStrings = ["ul", "ur", "ll", "lr"]
    let backgroundImageView = UIImageView(image: UIImage(named: "Title Screen Graident"))
    
    override func didMoveToView(view: SKView) {

        //Get NSUserDefaults
        if NSUserDefaults.standardUserDefaults().integerForKey(DefaultsKeys.currencyKey) as Int? != nil {
            Cloud.currency = NSUserDefaults.standardUserDefaults().integerForKey(DefaultsKeys.currencyKey)
        }
        if let lockedForPlayersArray = NSUserDefaults.standardUserDefaults().arrayForKey(DefaultsKeys.lockedForPlayersKey) as? [Bool] {
            Cloud.lockedForPlayers = lockedForPlayersArray
        }
        if let lockedForThemesArray = NSUserDefaults.standardUserDefaults().arrayForKey(DefaultsKeys.lockedForThemesKey) as? [Bool] {
            Cloud.lockedForThemes = lockedForThemesArray
        }
        if let playerString = NSUserDefaults.standardUserDefaults().stringForKey(DefaultsKeys.playerStringKey) {
            Cloud.playerString = playerString
        }
        if let themeString = NSUserDefaults.standardUserDefaults().stringForKey(DefaultsKeys.themeStringKey) {
            Cloud.themeString = themeString
        }
        if NSUserDefaults.standardUserDefaults().integerForKey(DefaultsKeys.highScoreKey) as Int? != nil {
            Cloud.highScore = NSUserDefaults.standardUserDefaults().integerForKey(DefaultsKeys.highScoreKey)
        }
        if NSUserDefaults.standardUserDefaults().boolForKey(DefaultsKeys.musicKey) as Bool? != nil{
            Cloud.sound = NSUserDefaults.standardUserDefaults().boolForKey(DefaultsKeys.musicKey)
        }
        if let showTutorial = NSUserDefaults.standardUserDefaults().boolForKey(DefaultsKeys.showTutorialKey) as Bool? {
            Cloud.showTutorial = showTutorial
        }
        if let color = NSUserDefaults.standardUserDefaults().stringForKey(DefaultsKeys.colorKey) {
            Cloud.color = color
        }
        if let askForRating = NSUserDefaults.standardUserDefaults().boolForKey(DefaultsKeys.askForRatingKey) as Bool? {
            Cloud.canAskForRating = askForRating
        }
        if let gameCounter = NSUserDefaults.standardUserDefaults().integerForKey(DefaultsKeys.gameCounterKey) as Int? {
            Cloud.gameCounter = gameCounter
        }
        backgroundImageView.frame = self.view!.frame
        if Cloud.backFromSettings || Cloud.backFromShop {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                self.view!.insertSubview(self.backgroundImageView, atIndex: 0)
            })
        }else{
            self.view!.addSubview(self.backgroundImageView)
        }
        let screenWidth = self.view!.frame.width
        //Check which iPhone model
        switch screenWidth {
        case 667.0:
            Cloud.model = "iPhone 6"
            break
        case 568.0:
            Cloud.model = "iPhone 5"
            break
        case 736.0:
            Cloud.model = "iPhone 6+"
            break
        case 480.0:
            Cloud.model = "iPhone 4s"
            break
        default:
            break
        }
        
        //Append corner images to array
        for imageName in cornerImageStrings {
            cornerImages.append(UIImageView(image: UIImage(named: imageName)))
        }
        
        //Add corner images to corners
        for imageView in cornerImages {
            let thisIt = cornerImages.indexOf(imageView)
            switch cornerImageStrings[thisIt!] {
            case "ul":
                if Cloud.backFromSettings {
                    imageView.frame = CGRectMake(0 - self.view!.frame.maxX, 0, 100, 100)
                }else if Cloud.backFromShop {
                    imageView.frame = CGRectMake(0 + self.view!.frame.maxX, 0, 100, 100)
                }else{
                    imageView.frame = CGRectMake(0, 0, 100, 100)
                }
            case "ur":
                imageView.frame.size = CGSizeMake(100, 100)
                if Cloud.backFromSettings {
                    imageView.frame.origin = CGPointMake(((self.view?.frame.maxX)! - imageView.frame.size.width) - self.view!.frame.maxX, 0)
                }else if Cloud.backFromShop {
                    imageView.frame.origin = CGPointMake(((self.view?.frame.maxX)! - imageView.frame.size.width) + self.view!.frame.maxX, 0)
                }else{
                    imageView.frame.origin = CGPointMake((self.view?.frame.maxX)! - imageView.frame.size.width, 0)
                }
            case "ll":
                imageView.frame.size = CGSizeMake(100, 100)
                if Cloud.backFromSettings {
                    imageView.frame.origin = CGPointMake(0 - self.view!.frame.maxX, self.view!.frame.maxY - imageView.frame.size.height)
                }else if Cloud.backFromShop{
                    imageView.frame.origin = CGPointMake(0 + self.view!.frame.maxX, self.view!.frame.maxY - imageView.frame.size.height)
                }
                else{
                    imageView.frame.origin = CGPointMake(0, self.view!.frame.maxY - imageView.frame.size.height)
                }
            case "lr":
                imageView.frame.size = CGSizeMake(100, 100)
                if Cloud.backFromSettings {
                    imageView.frame.origin = CGPointMake(((self.view?.frame.maxX)! - imageView.frame.size.width) - self.view!.frame.maxX , self.view!.frame.maxY - imageView.frame.size.height)
                }else if Cloud.backFromShop {
                    imageView.frame.origin = CGPointMake(((self.view?.frame.maxX)! - imageView.frame.size.width) + self.view!.frame.maxX , self.view!.frame.maxY - imageView.frame.size.height)
                }else{
                    imageView.frame.origin = CGPointMake((self.view?.frame.maxX)! - imageView.frame.size.width, self.view!.frame.maxY - imageView.frame.size.height)
                }
            default:
                break
            }
            self.view?.addSubview(imageView)
        }
        
        //Title image
        titleImg.frame.size = CGSizeMake(400, 800)
        if Cloud.model != "iPhone 4s" && Cloud.model != "iPhone 5" {
            titleImg.center = CGPointMake(self.view!.frame.midX, 100)
        }else{
            titleImg.center = CGPointMake(self.view!.frame.midX, 85)
        }
        titleImg.image = UIImage(named: "Logo")
        titleImg.contentMode = UIViewContentMode.ScaleAspectFit
        self.view!.addSubview(titleImg)

        //Currency label
        currencyLabel.text = String(Cloud.currency)
        currencyLabel.frame.size = CGSize(width: 60, height: 15)
        currencyLabel.center = CGPointMake(self.view!.center.x, self.view!.frame.minY + 10)
        currencyLabel.textAlignment = NSTextAlignment.Right
        currencyLabel.font = UIFont(name: "VAGRound", size: 20)
        self.view!.addSubview(currencyLabel)
        
        var buttonPos: CGFloat = 200
        var buttonSize: CGFloat = 100
        if Cloud.model == "iPhone 4s" {
            buttonPos = 175
            buttonSize = 80
        }
        
        //Three main buttons
        playButton.setImage(UIImage(named: "playButton"), forState: .Normal)
        playButton.addTarget(self, action: #selector(TitleScene.play), forControlEvents: .TouchUpInside)
        playButton.frame.size.width = buttonSize
        playButton.frame.size.height = buttonSize
        if Cloud.backFromSettings {
            playButton.center = CGPointMake(self.view!.center.x - self.view!.frame.maxX, (self.view?.center.y)!)
        }else if Cloud.backFromShop {
            playButton.center = CGPointMake(self.view!.center.x + self.view!.frame.maxX, (self.view?.center.y)!)
        }else{
            playButton.center = self.view!.center
        }
        view.addSubview(playButton)
        
        shopButton.setImage(UIImage(named: "ShopButton"), forState: .Normal)
        shopButton.frame.size.width = buttonSize
        shopButton.frame.size.height = buttonSize
        if Cloud.backFromSettings {
            shopButton.center = CGPointMake(self.view!.frame.midX - buttonPos - self.view!.frame.maxX, self.view!.center.y)
        }else if Cloud.backFromShop {
            shopButton.center = CGPointMake(self.view!.frame.midX - buttonPos + self.view!.frame.maxX, self.view!.center.y)
        }else{
            shopButton.center.x = self.view!.frame.midX - buttonPos
            shopButton.center.y = self.view!.center.y
        }
        shopButton.addTarget(self, action: #selector(TitleScene.shop), forControlEvents: .TouchUpInside)
        view.addSubview(shopButton)
        
        settingsButton.setImage(UIImage(named: "SettingsButton"), forState: .Normal)
        settingsButton.frame.size = CGSize(width: buttonSize, height: buttonSize)
        if  Cloud.backFromSettings {
            settingsButton.center = CGPointMake(self.view!.frame.midX + buttonPos - self.view!.frame.maxX, self.view!.center.y)
            currencyLabel.center.x -= self.view!.frame.maxX
            titleImg.center.x -= self.view!.frame.maxX
        }else if Cloud.backFromShop{
            settingsButton.center = CGPointMake(self.view!.frame.midX + buttonPos + self.view!.frame.maxX, self.view!.center.y)
            titleImg.center.x += self.view!.frame.maxX
        }else{
            settingsButton.center.x = self.view!.frame.midX + buttonPos
            settingsButton.center.y = self.view!.center.y
        }
        settingsButton.addTarget(self, action: #selector(TitleScene.settings), forControlEvents: .TouchUpInside)
        self.view!.addSubview(settingsButton)
        
        //If transitioning, position elements accordingly
        if Cloud.backFromSettings {
            UIView.animateWithDuration(1, animations: {
                self.playButton.center.x += self.view!.frame.maxX
                self.shopButton.center.x += self.view!.frame.maxX
                self.settingsButton.center.x += self.view!.frame.maxX
                self.titleImg.center.x += self.view!.frame.maxX
                for corner in self.cornerImages {
                    corner.frame.origin.x += self.view!.frame.maxX
                }
                self.currencyLabel.center.x += self.view!.frame.maxX
            })
            Cloud.backFromSettings = false
        }else if Cloud.backFromShop{
            UIView.animateWithDuration(1, animations: {
                self.playButton.center.x -= self.view!.frame.maxX
                self.shopButton.center.x -= self.view!.frame.maxX
                self.settingsButton.center.x -= self.view!.frame.maxX
                self.titleImg.center.x -= self.view!.frame.maxX
                for corner in self.cornerImages {
                    corner.frame.origin.x -= self.view!.frame.maxX
                }
            })
            Cloud.backFromShop = false
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let titleMusicPlayer = appDelegate.musicPlayer
        
        if Cloud.sound {
            if Cloud.gameIsOpened {
                appDelegate.play()
            }else{
                if !titleMusicPlayer.playing {
                    titleMusicPlayer.play()
                }else if appDelegate.music == NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("GameMusic", ofType: "mp3")!){
                    fadeVolumeAndPause()
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                        appDelegate.music = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("TitleMusicv3", ofType: "mp3")!)
                        appDelegate.play()
                    })
                }
                
            }
        }

    }
    
    //If settings button pressed
    func settings(){
        let skView = self.view! as SKView
        let scene = SettingsScene(fileNamed: "SettingsScene")
        scene!.scaleMode = .AspectFill
        UIView.animateWithDuration(1, animations: {
            //Transition elements (move to the left)
            self.currencyLabel.center.x -= self.view!.frame.maxX
            self.playButton.center.x -= self.view!.frame.maxX
            self.shopButton.center.x -= self.view!.frame.maxX
            self.settingsButton.center.x -= self.view!.frame.maxX
            self.titleImg.center.x -= self.view!.frame.maxX
            for image in self.cornerImages {
                image.frame.origin.x -= self.view!.frame.maxX
            }
            }, completion: { finished in
                self.backgroundImageView.removeFromSuperview()

        })
        skView.presentScene(scene)
    }
    
    //If play button pressed
    func play(){
        let skView = self.view! as SKView
        let scene = GameScene(fileNamed:"GameScene")
        scene!.scaleMode = .AspectFill
        currencyLabel.removeFromSuperview()
        UIView.animateWithDuration(1.0, animations: {
            //transition elements (fade out)
            self.playButton.alpha = 0.0
            self.shopButton.alpha = 0.0
            self.settingsButton.alpha = 0.0
            self.backgroundImageView.alpha = 0.0
            self.titleImg.alpha = 0.0
            for image in self.cornerImages {
                image.alpha = 0.0
            }
            skView.presentScene(scene)
            }, completion: { finshed in
                self.playButton.removeFromSuperview()
                self.shopButton.removeFromSuperview()
                self.settingsButton.removeFromSuperview()
                for image in self.cornerImages {
                    image.removeFromSuperview()
                }
        })
        if Cloud.sound {
            fadeVolumeAndPause()
        }
    }
    
    //If shop button pressed
    func shop(){
        let skView = self.view! as SKView
        let scene = ShopScene(fileNamed:"ShopScene")
        scene!.scaleMode = .AspectFill
        UIView.animateWithDuration(1, animations: {
            //Transition elements (move to the right)
            self.playButton.center.x += self.view!.frame.maxX
            self.shopButton.center.x += self.view!.frame.maxX
            self.settingsButton.center.x += self.view!.frame.maxX
            self.titleImg.center.x += self.view!.frame.maxX
            for corner in self.cornerImages {
                corner.frame.origin.x += self.view!.frame.maxX
            }
            self.currencyLabel.removeFromSuperview()
            }, completion: { finished in
                self.backgroundImageView.removeFromSuperview()
         })
        skView.presentScene(scene)
    }
    
    //Fades volume (called when play button pressed)
    func fadeVolumeAndPause(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let titleMusicPlayer = appDelegate.musicPlayer
        if titleMusicPlayer.volume > 0.1 {
            titleMusicPlayer.volume = titleMusicPlayer.volume - 0.1
            
            let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.fadeVolumeAndPause()
            })
            
        } else {
            titleMusicPlayer.pause()
            titleMusicPlayer.volume = 1.0
        }
    }
    
    func setupButton(button: UIButton, center: CGPoint?, origin: CGPoint?, size: CGSize, image: UIImage, selector: Selector){
        button.frame.size = size
        button.setImage(image, forState: .Normal)
        button.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
        if origin != nil {
            button.frame.origin = origin!
        }else if center != nil {
            button.center = center!
        }
        self.view!.addSubview(button)
    }
    
}
