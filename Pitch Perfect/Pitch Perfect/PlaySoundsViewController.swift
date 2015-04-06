//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jose Ochoa on 3/21/15.
//  Copyright (c) 2015 Primattebrain. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    

        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile (forReading: receivedAudio.filePathUrl, error: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func PlaySlowSound(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.play()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 1.0
    }

    @IBAction func PlayFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.play()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = 2.03
    }

    @IBAction func StopPlayback(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0

    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.play()
        audioPlayer.currentTime = 0.0
        playAudioWithVariable(1050)
    
    }
    
    
    @IBAction func playEchoAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.play()
        audioPlayer.currentTime = 0.0
        playAudioWithVariableEcho(88)

    }
    
    
    func playAudioWithVariableEcho(Delay: Float){
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changeEchoEffect = AVAudioUnitDelay()
        changeEchoEffect.wetDryMix = Delay
        audioEngine.attachNode(changeEchoEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeEchoEffect, format: nil)
        audioEngine.connect(changeEchoEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    
    
    
    func playAudioWithVariable(Pitch: Float){

        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
    
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = Pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariable(-1000)
        
    }
    

    
}
