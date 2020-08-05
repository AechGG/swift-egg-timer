//
//  ViewController.swift
//  swift-egg-timer
//
//  Created by Harrison Gittos on 05/08/2020.
//  Copyright © 2020 Harrison Gittos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    let times : [String : Int] = ["Soft": 5, "Medium": 7, "Hard": 12];
    var countdownTimer: Timer = Timer();
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle;
        totalTime = times[hardness ?? "Soft"]! * 60;
        
        countdownTimer.invalidate();
        startTimer();
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        print("\(timeFormatted(totalTime))")

        if totalTime != 0 {
            totalTime -= 1
        } else {
            countdownTimer.invalidate();
            titleLabel.text = "Done!";
        }
    }

    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

