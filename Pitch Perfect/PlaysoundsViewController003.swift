//
//  PlaysoundsViewController003.swift
//  Pitch Perfect
//
//  Created by Cesar Ramirez on 3/9/15.
//  Copyright (c) 2015 Cesar Ramirez. All rights reserved.

import UIKit
import AVFoundation

class PlaysoundsViewController003: UIViewController {

    var playAudio:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        playAudio = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        playAudio.enableRate = true      
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    @IBAction func slowPitch(sender: AnyObject) {
        playDiffspeeds(0.5)
    }

    @IBAction func fastPitch(sender: UIButton) {
        playDiffspeeds(2.0)
    }
    
    func playDiffspeeds (speed: Float){
        stopAll()
        playAudio.rate = speed
        playAudio.currentTime = 0.0
        playAudio.play()
    }
    
    @IBAction func platChimunkaudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthVadersound(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAll()
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }

    @IBAction func stopPlay(sender: UIButton) {
        stopAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func stopAll(){
        playAudio.stop()
        audioEngine.stop()
        audioEngine.reset()
    }

}
