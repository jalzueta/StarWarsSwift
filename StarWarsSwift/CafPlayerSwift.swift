//
//  CafPlayerSwift.swift
//  StarWarsSwift
//
//  Created by Javi Alzueta on 13/5/15.
//  Copyright (c) 2015 FillinGAPPs. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class CafPlayerSwift {
   
    var player = AVAudioPlayer()
    
    class func cafPlayer() -> CafPlayerSwift?{
        return self.init()
    }
    
    func playSoundData(data: NSData?){
        
        if let soundData = data{
            let miSoundData: NSData! = data!
            player = AVAudioPlayer(data: miSoundData, fileTypeHint: AVFileTypeCoreAudioFormat, error: nil)
            player.numberOfLoops = 0
            player.play()
        }
    }
    
}
