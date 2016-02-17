//
//  PlaySoundViewController.swift
//  MyVoice
//
//  Created by Cathy Oun on 2/16/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
  var soundEffect: AVAudioPlayer!
  var receivedAudio: RecordAudio!
  var audioEngine: AVAudioEngine!
  var audioFile: AVAudioFile!
  override func viewDidLoad() {
    super.viewDidLoad()
    audioEngine = AVAudioEngine()
    audioFile = try! AVAudioFile(forReading: receivedAudio.filePathURL) // convert NSURL to AVAudioFile type
    soundEffect = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL)
    soundEffect.enableRate = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func snailButtonPressed(sender: AnyObject) {
    playSoundWithRate(0.5)
  }
  
  @IBAction func rabbitButtonPressed(sender: AnyObject) {
    playSoundWithRate(1.5)
  }
  
  @IBAction func chipmunkButtonPressed(sender: AnyObject) {
    playSoundWithPitch(1000)
  }
  
  @IBAction func dvButtonPressed(sender: AnyObject) {
    playSoundWithPitch(-1000)
  }
  
  @IBAction func stopButtonPressed(sender: AnyObject) {
    resetAndStopSound()
  }
  
  
  func playSoundWithRate(rate: Float) {
    resetAndStopSound()
    
    soundEffect.rate = rate
    soundEffect.currentTime = 0.0
    soundEffect.play()
  }
  
  func playSoundWithPitch(pitch: Float) {
    resetAndStopSound()
    
    let audioPlayerNode = AVAudioPlayerNode()
    audioEngine.attachNode(audioPlayerNode)
    
    let changePitchEffect = AVAudioUnitTimePitch()
    changePitchEffect.pitch = pitch
    audioEngine.attachNode(changePitchEffect)
    
    audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
    audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
    audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
    try! audioEngine.start()
    audioPlayerNode.play()
    
  }
  
  func resetAndStopSound() {
    soundEffect.stop()
    audioEngine.stop()
    audioEngine.reset()
  }
}
