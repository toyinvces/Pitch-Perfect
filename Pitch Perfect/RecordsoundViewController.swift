//
//  RecordsoundViewController.swift
//  Pitch Perfect
//
//  Created by Cesar Ramirez on 3/8/15.
//  Copyright (c) 2015 Cesar Ramirez. All rights reserved.

import UIKit
import AVFoundation

class RecordsoundViewController: UIViewController, AVAudioRecorderDelegate{

    @IBOutlet weak var recordinginProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var pressTorecord: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        pressTorecord.hidden = false
        stopButton.hidden = true
        recordButton.enabled = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        pressTorecord.hidden = true
        recordinginProgress.hidden = false
        stopButton.hidden  = false
        recordButton.enabled = false
        
        println("Recording in Progress")
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
     func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            
            recordedAudio = RecordedAudio(filePathUrl: recorder.url!, title: recorder.url.lastPathComponent!)
        
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            println("recording was not sucessful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundVC:PlaysoundsViewController003 = segue.destinationViewController as PlaysoundsViewController003
            let data = sender as RecordedAudio
            playSoundVC.receivedAudio = data
        }
    }
    
    @IBAction func stop(sender: UIButton) {
        recordinginProgress.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
}

