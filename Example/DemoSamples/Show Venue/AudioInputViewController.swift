//
//  ViewController.swift
//  Note & Remind
//
//  Created by Erick Sanchez on 10/20/18.
//  Copyright © 2018 CapTech. All rights reserved.
//

import UIKit
import Speech

protocol AudioInputViewControllerDelegate: class {
    func audioInput(_ audioInputViewController: AudioInputViewController, didFinishWith text: String)
}

class AudioInputViewController: UIViewController {
    
    // MARK: - VARS
    
    weak var delegate: AudioInputViewControllerDelegate?
    
    private var isShowingMic: Bool {
        set {
            buttonMic.isHidden = !newValue
            buttonAction.isHidden = newValue
            
            //buttonAction is showing
            if newValue == false {
                updateConfirmButton()
            }
        }
        get {
            return !buttonMic.isHidden
        }
    }
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var speechResult = SFSpeechRecognitionResult()
    
    // MARK: - RETURN VALUES
    
    // MARK: - METHODS
    
    func begin() {
        isShowingMic = true
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            // The callback may not be called on the main thread. Add an
            // operation to the main queue to update the record button's state.
            OperationQueue.main.addOperation {
                var alertTitle = ""
                var alertMsg = ""
                
                switch authStatus {
                case .authorized:
                    do {
                        try self.startRecording()
                    } catch {
                        alertTitle = "Recorder Error"
                        alertMsg = "There was a problem starting the speech recorder"
                    }
                    
                case .denied:
                    alertTitle = "Speech recognizer not allowed"
                    alertMsg = "You enable the recgnizer in Settings"
                    
                case .restricted, .notDetermined:
                    alertTitle = "Could not start the speech recognizer"
                    alertMsg = "Check your internect connection and try again"
                    
                }
                if alertTitle != "" {
                    let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.isShowingMic = false
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func updateResult(with text: String?) {
        self.textViewResult.text = text
    }
    
    private func updateConfirmButton() {
        if textViewResult.text.isEmpty {
            
            //no text has been collected from mic
            self.buttonAction.setTitle("Record", for: .normal)
            
        } else {
            
            //there is text collected
            self.buttonAction.setTitle("Confirm", for: .normal)
        }
    }
    
    // MARK: - IBACTIONS
    
    @IBOutlet weak var textViewResult: UITextView!
//    @IBOutlet weak var isRecordingLabel: UILabel!
    
    @IBOutlet weak var buttonAction: UIButton!
    @IBAction func pressActionButton(_ sender: Any) {
        if textViewResult.text.isEmpty {
            
            //no text has been collected from mic
            begin()
            
        } else {
            
            //there is text collected
            self.delegate?.audioInput(self, didFinishWith: self.textViewResult.text)
            self.presentingViewController?.dismiss(animated: true)
        }
    }
    
    @IBOutlet weak var buttonMic: UIButton!
    
    // MARK: - LIFE CYCLE

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        begin()
    }
    
    private func startRecording() throws {
        if !audioEngine.isRunning {
            let timer = Timer(timeInterval: 5.0, target: self, selector: #selector(AudioInputViewController.timerEnded), userInfo: nil, repeats: false)
            RunLoop.current.add(timer, forMode: .commonModes)
            
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
            
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            
            guard let inputNode = audioEngine.inputNode else { fatalError("There was a problem with the audio engine") }
            guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create the recognition request") }
            
            // Configure request so that results are returned before audio recording is finished
            recognitionRequest.shouldReportPartialResults = true
            
            // A recognition task is used for speech recognition sessions
            // A reference for the task is saved so it can be cancelled
            recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
                var isFinal = false
                
                if let result = result {
                    print("result: \(result.isFinal)")
                    isFinal = result.isFinal
                    
                    self.speechResult = result
                    self.updateResult(with: result.bestTranscription.formattedString)
                    
                }
                
                if error != nil || isFinal {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                }
                
//                self.addNote.isEnabled = self.recordedTextLabel.text != ""
//                self.addReminder.isEnabled = self.recordedTextLabel.text != ""
            }
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                self.recognitionRequest?.append(buffer)
            }
            
            print("Begin recording")
            audioEngine.prepare()
            try audioEngine.start()
            
//            isRecordingLabel.text = "Recording"
        }
        
    }
    
    @objc func timerEnded() {
        // If the audio recording engine is running stop it and remove the SFSpeechRecognitionTask
        if audioEngine.isRunning {
            stopRecording()
//            checkForActionPhrases()
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        // Cancel the previous task if it's running
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        isShowingMic = false
    }
    
//    func checkForActionPhrases() {
//        var addNote = false
//        var addReminder = false
//
//        for segment in speechResult.bestTranscription.segments {
//            // Don't search until the transcription size is at least
//            // the size of the shortest phrase
//            if segment.substringRange.location >= 5 {
//                // Separate segments to single words
//                let best = speechResult.bestTranscription.formattedString
//                let indexTo = best.index(best.startIndex, offsetBy: segment.substringRange.location)
//                let substring = best.substring(to: indexTo)
//
//                // Search for phrases
//                addNote = substring.lowercased().contains("note ")
//                addReminder = substring.lowercased().contains("remind")
//            }
//        }
//
////        if addNote {
////            recordedTextLabel.text = remove(commands: noteCommands, from: recordedTextLabel.text)
////            addNoteTapped(nil)
////        } else if addReminder {
////            recordedTextLabel.text = remove(commands: remindCommands, from: recordedTextLabel.text)
////            addReminderTapped(nil)
////        }
//    }
}

extension AudioInputViewController: SFSpeechRecognizerDelegate {
    
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        print("Recognizer availability changed: \(available)")
        
        if !available {
            let alert = UIAlertController(title: "There was a problem accessing the recognizer", message: "Please try again later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
}
