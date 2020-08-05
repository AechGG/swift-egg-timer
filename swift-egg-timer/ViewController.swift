//
//  ViewController.swift
//  swift-egg-timer
//
//  Created by Harrison Gittos on 05/08/2020.
//  Copyright © 2020 Harrison Gittos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let times : Dictionary = ["Soft": 5, "Medium": 7, "Hard": 12];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle;
        print(times[hardness!]);
    }
}

