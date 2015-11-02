//
//  AudioPlayer+MP3.swift
//  AppleTVPong
//
//  Created by Nahuel Marisi on 2015-11-02.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import AVFoundation


extension AVAudioPlayer {
    class func audioPlayerForMP3(filename : String) -> AVAudioPlayer? {
        do {
            guard let soundFilePath = NSBundle.mainBundle().pathForResource(filename, ofType: "mp3")  else {
                return nil
            }
            guard let url = NSURL(string:soundFilePath) else { return nil }
            let audioPlayer = try AVAudioPlayer(contentsOfURL:url)
            audioPlayer.prepareToPlay()
            return audioPlayer
        } catch {
            return nil
        }
    }
}

