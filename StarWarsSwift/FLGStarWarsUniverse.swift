//
//  FLGStarWarsUniverse.swift
//  StarWarsSwift
//
//  Created by Javi Alzueta on 11/5/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

import Foundation
import UIKit

class FLGStarWarsUniverse: NSObject {
   
    var rebels: NSMutableArray
    var imperials: NSMutableArray
    
    var rebelCount: Int{
        get{
            var count: Int = self.rebels.count
            return count
        }
    }
    
    var imperialCount: Int{
        get{
            var count: Int = self.imperials.count
            return count
        }
    }
    
    override init() {
            
            self.imperials = NSMutableArray()
            self.rebels = NSMutableArray()
            
            var urlString: String = "http://en.wikipedia.org/wiki/Darth_Vader"
            if let vaderUrl = NSURL(string: urlString),
                let auxURL = NSBundle.mainBundle().URLForResource("vader", withExtension: "caf"),
                let vaderSound = NSData(contentsOfURL: auxURL),
                let vaderImage = UIImage(named: "darthVader.jpg"){
                    let vader: FLGStarWarsCharacter = FLGStarWarsCharacter(name: "Anakin Skywalker", alias: "Darth Vader", wikiURL: vaderUrl, soundData: vaderSound, photo: vaderImage)
                    self.imperials.addObject(vader)
            }
            
            urlString = "http://en.wikipedia.org/wiki/Grand_Moff_Tarkin"
            if let tarkinUrl = NSURL(string: urlString),
                let auxURL = NSBundle.mainBundle().URLForResource("tarkin", withExtension: "caf"),
                let tarkinSound = NSData(contentsOfURL: auxURL),
                let tarkinImage = UIImage(named: "tarkin.jpg"){
                    let tarkin: FLGStarWarsCharacter = FLGStarWarsCharacter(name: "Wilhuf Tarkin", alias: "Grand Moff Tarkin", wikiURL: tarkinUrl, soundData: tarkinSound, photo: tarkinImage)
                    self.imperials.addObject(tarkin)
            }
            
            urlString = "http://en.wikipedia.org/wiki/Palpatine"
            if let palpatineUrl = NSURL(string: urlString),
                        let auxURL = NSBundle.mainBundle().URLForResource("palpatine", withExtension: "caf"),
                        let palpatineSound = NSData(contentsOfURL: auxURL),
                        let palpatineImage = UIImage(named: "palpatine.jpg"){
                let palpatine: FLGStarWarsCharacter = FLGStarWarsCharacter(name: "Palpatine", alias: "Darth Sidious", wikiURL: palpatineUrl, soundData: palpatineSound, photo: palpatineImage)
                self.imperials.addObject(palpatine)
            }
            
            urlString = "http://en.wikipedia.org/wiki/Chewbacca"
            if let chewieUrl = NSURL(string: urlString),
                        let auxURL = NSBundle.mainBundle().URLForResource("chewbacca", withExtension: "caf"),
                        let chewieSound = NSData(contentsOfURL: auxURL),
                        let chewieImage = UIImage(named: "chewbacca.jpg"){
                let chewie: FLGStarWarsCharacter = FLGStarWarsCharacter(alias: "Chewbacca", wikiURL: chewieUrl, soundData: chewieSound, photo: chewieImage)
                self.rebels.addObject(chewie)
            }
            
            urlString = "http://en.wikipedia.org/wiki/C-3PO"
            if let c3poUrl = NSURL(string: urlString),
                    let auxURL = NSBundle.mainBundle().URLForResource("c3po", withExtension: "caf"),
                    let c3poSound = NSData(contentsOfURL: auxURL),
                    let c3poImage = UIImage(named: "c3po.jpg"){
                let c3po: FLGStarWarsCharacter = FLGStarWarsCharacter(alias: "C-3PO", wikiURL: c3poUrl, soundData: c3poSound, photo: c3poImage)
                self.rebels.addObject(c3po)
            }
            
            urlString = "http://en.wikipedia.org/wiki/Yoda"
            if let yodaUrl = NSURL(string: urlString),
                    let auxURL = NSBundle.mainBundle().URLForResource("yoda", withExtension: "caf"),
                    let yodaSound = NSData(contentsOfURL: auxURL),
                    let yodaImage = UIImage(named: "yoda.jpg"){
                let yoda: FLGStarWarsCharacter = FLGStarWarsCharacter(name: "Minch Yoda" ,alias: "Master Yoda", wikiURL: yodaUrl, soundData: yodaSound, photo: yodaImage)
                self.rebels.addObject(yoda)
            }
            
            urlString = "http://en.wikipedia.org/wiki/R2-D2"
            if let r2d2Url = NSURL(string: urlString),
                    let auxURL = NSBundle.mainBundle().URLForResource("r2-d2", withExtension: "caf"),
                    let r2d2Sound = NSData(contentsOfURL: auxURL),
                    let r2d2Image = UIImage(named: "R2-D2.jpg"){
                let r2d2: FLGStarWarsCharacter = FLGStarWarsCharacter(alias: "R2-D2", wikiURL: r2d2Url, soundData: r2d2Sound, photo: r2d2Image)
                self.rebels.addObject(r2d2)
            }

    }
    
    func rebelAtIndex(index: Int) -> FLGStarWarsCharacter?{
        var optional: FLGStarWarsCharacter? = self.rebels[index] as? FLGStarWarsCharacter
        return optional
    }
    
    func imperialAtIndex(index: Int) -> FLGStarWarsCharacter?{
        var optional: FLGStarWarsCharacter? = self.imperials[index] as? FLGStarWarsCharacter
        return optional
    }
}
