//
//  RecordSoundViewController.swift
//  MyVoice
//
//  Created by Cathy Oun on 2/11/16.
//  Copyright © 2016 Cathy Oun. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
  // gloabl variables
  var audioRecorder: AVAudioRecorder!
  var recordedAudio : RecordAudio!
  
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var recordingLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func viewWillAppear(animated: Bool) {
    stopButton.hidden = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func recordAction(sender: AnyObject) {
    //TODO: record
    recordingLabel.hidden = false
    recordingLabel.text = "Recording"
    stopButton.hidden = false
    recordButton.enabled = false
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    
//    let currentDate = NSDate()
//    let formatter = NSDateFormatter()
//    formatter.dateFormat = "ddMMyyyy-HHmmss"
//    let recordingName = formatter.stringFromDate(currentDate) + ".wav"
    let recordingName = "my_audio.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    print(pathArray)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
    try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
    
    audioRecorder.meteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
    audioRecorder.delegate = self

  }

  @IBAction func stopRecording(sender: AnyObject) {
    recordingLabel.hidden = true
    stopButton.hidden = true
    recordButton.enabled = true
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
  }
  
  
  func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    if (flag) {
      recordedAudio = RecordAudio()
      recordedAudio.filePathURL = recorder.url
      recordedAudio.title = recorder.url.lastPathComponent
      self.performSegueWithIdentifier("SegueSoundFile", sender: recordedAudio)

    } else {
      recordButton.enabled = true
      stopButton.hidden = true
    }
    
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "SegueSoundFile"){
      let playSoundVC: PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
      let data = sender as! RecordAudio
      playSoundVC.receivedAudio = data
    }
  }
}

