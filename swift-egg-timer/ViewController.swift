//
//  ViewController.swift
//  swift-egg-timer
//
//  Created by Harrison Gittos on 05/08/2020.
//  Copyright © 2020 Harrison Gittos. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?
    let times : [String : Int] = ["Soft": 5, "Medium": 7, "Hard": 12];
    var countdownTimer: Timer = Timer();
    var currentTime = 60;
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle;
        totalTime = times[hardness ?? "Soft"]! * 60;
        currentTime = totalTime;
        
        countdownTimer.invalidate();
        startTimer();
    }
    
    func startTimer() {
        progressBar.progress = 1.0;
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        print("\(timeFormatted(currentTime))")
        
        if currentTime != 0 {
            progressBar.progress = Float(currentTime) / Float(totalTime);
            currentTime -= 1
        } else {
            progressBar.progress = 0.0;
            countdownTimer.invalidate();
            titleLabel.text = "Done!";
            playSound(soundName: "alarm_sound");
        }
    }

    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func playSound(soundName: String!) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

